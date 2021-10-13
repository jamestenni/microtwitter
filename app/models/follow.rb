class Follow < ApplicationRecord
  belongs_to :follower_user, class_name: 'User'
  belongs_to :followee_user, class_name: 'User'
end
