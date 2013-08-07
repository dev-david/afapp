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

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
