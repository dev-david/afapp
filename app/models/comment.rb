# == Schema Information
#
# Table name: comments
#
#  id                         :integer          primary key
#  user_id                    :integer
#  content                    :string(255)
#  micropost_id               :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  comment_image_file_name    :string(255)
#  comment_image_content_type :string(255)
#  comment_image_file_size    :integer
#  comment_image_updated_at   :datetime
#  comment_image_remote_url   :string(255)
#  tag                        :string(255)
#


require 'open-uri'

class Comment < ActiveRecord::Base

	include PublicActivity::Model
	tracked only: :create, owner: ->(controller, model) { controller && controller.current_user }
	# tracked except: :destroy, recipient: ->(controller, model) { model && model.user }

	belongs_to :micropost
	belongs_to :user
	has_many :likes, dependent: :destroy

	attr_accessible :user_id, :content, :micropost_id, :comment_image, :comment_image_remote_url, :tag, :tag_list
	acts_as_taggable

	has_attached_file :comment_image, :styles => { :thumb => "80x80!", :medium => "300x300>" }, :default_url => "/images/:style/aflogo.png"

	validates :content, presence: true, length: { maximum: 1000 }
	validates :user_id, presence: true
	validates :micropost_id, presence: true
	validates :tag_list, :length => { maximum: 5 } #Limit to 5 tags max
	validate :each_tag

	validates_attachment_size :comment_image, :less_than => 3.megabytes
	validates_attachment_content_type :comment_image, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

	def comment_image_remote_url=(url_value)
	    self.comment_image = URI.parse(url_value) unless url_value.blank?
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
