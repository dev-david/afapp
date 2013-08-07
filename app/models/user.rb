# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  user_name              :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean          default(FALSE)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  avatar_url             :string(255)
#  avatar_remote_url      :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  auth_token             :string(255)
#

require 'open-uri'

class User < ActiveRecord::Base

	include PublicActivity::Common
	
	attr_accessible :email, :first_name, :last_name, :user_name, :password, :password_confirmation, :avatar, :avatar_remote_url
	has_secure_password

	# tracked only: :create, owner: ->(controller, model) { controller && controller.current_user }

	has_attached_file :avatar, :styles => { :thumb => "80x80!", :tiny => "50x50!" }, :default_url => "/images/:style/aflogo.png"
	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy

	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	validates :first_name, :last_name, presence: true, length: { maximum: 50 }
	validates :user_name, presence: true, 
				uniqueness: { case_sensitive: false },
				length: { maximum: 20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
				format: { with: VALID_EMAIL_REGEX },
				uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true
	validates_attachment_size :avatar, :less_than => 3.megabytes
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
	# validates_presence_of :avatar_remote_url, :if => :avatar_url_provided?, :message => 'is invalid or inaccessible'

	default_scope order: 'users.user_name asc'

	def avatar_remote_url=(url_value)
	    self.avatar = URI.parse(url_value) unless url_value.blank?
		rescue
	end

	def feed
	    Micropost.from_users_followed_by(self)
	end

	def following?(other_user)
		relationships.find_by_followed_id(other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def unfollow!(other_user)
		relationships.find_by_followed_id(other_user.id).destroy
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!(:validate => false)
		UserMailer.password_reset(self).deliver
	end

	private

	def avatar_url_provided?
	    !self.avatar_url.blank?
	end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

      

end
