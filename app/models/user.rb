class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, length: {minimum: 6}

  has_secure_password

  has_many :posts

  has_many :follower_users, class_name: 'Follow', foreign_key: 'follower_user_id'
  has_many :followee_users, class_name: 'Follow', foreign_key: 'followee_user_id'
end
