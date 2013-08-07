# == Schema Information
#
# Table name: microposts
#
#  id                                 :integer          not null, primary key
#  content                            :string(255)
#  user_id                            :integer
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  post_image_file_name               :string(255)
#  post_image_content_type            :string(255)
#  post_image_file_size               :integer
#  post_image_updated_at              :datetime
#  post_image_remote_url_file_name    :string(255)
#  post_image_remote_url_content_type :string(255)
#  post_image_remote_url_file_size    :integer
#  post_image_remote_url_updated_at   :datetime
#  tag                                :string(255)
#  title                              :string(255)
#

require 'open-uri'

class Micropost < ActiveRecord::Base

	include PublicActivity::Model
	tracked only: :create, owner: ->(controller, model) { controller && controller.current_user }
	# tracked except: :destroy, recipient: ->(controller, model) { model && model.user }

	attr_accessible :content, :post_image, :post_image_remote_url_file_name, :title, :tag, :tag_list
	acts_as_taggable
	
	belongs_to :user
	has_attached_file :post_image, :styles => { :thumb => "80x80!", :medium => "300x300>" }, :default_url => "/images/:style/aflogo.png"
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy

	validates :content, presence: true, length: { maximum: 3000 }
	validates :tag, length: { maximum: 30 }
	validates :tag_list, :length => { maximum: 5 } #Limit to 5 tags max
	validate :each_tag
	validates :user_id, presence: true
	validates_attachment_size :post_image, :less_than => 3.megabytes
	validates_attachment_content_type :post_image, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

	default_scope order: 'microposts.created_at DESC'

	# Returns microposts from the users being followed by the given user.
	def self.from_users_followed_by(user)
		followed_user_ids = "SELECT followed_id FROM relationships
		                     WHERE follower_id = :user_id"
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
		      user_id: user.id)
	end

	def post_image_remote_url_file_name=(url_value)
	    self.post_image = URI.parse(url_value) unless url_value.blank?
	    super
	end

	private

	def each_tag
		for tag in tag_list
			errors.add(:tag, "too long (maximum is 15 characters)") if tag.length > 15
			errors.add(:tag, "can't contain a period") if tag.include? '.'
		end
	end

end
