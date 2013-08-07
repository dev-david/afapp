# == Schema Information
#
# Table name: likes
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  micropost_id :integer
#  comment_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Like < ActiveRecord::Base
	include PublicActivity::Model
	tracked only: :create, owner: ->(controller, model) { controller && controller.current_user }
	# tracked except: :destroy, recipient: ->(controller, model) { model && model.user }

	belongs_to :user
	belongs_to :micropost
	belongs_to :comment
	# attr_accessible :title, :body
	attr_accessible :user_id, :micropost_id, :comment_id
	# make sure user_id cannot like same thing more than once
	validates_uniqueness_of :user_id, :scope => [:micropost_id, :comment_id]
end
