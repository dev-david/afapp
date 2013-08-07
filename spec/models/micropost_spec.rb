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

require 'spec_helper'

describe Micropost do
  pending "add some examples to (or delete) #{__FILE__}"
end
