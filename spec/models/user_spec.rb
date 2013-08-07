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

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
