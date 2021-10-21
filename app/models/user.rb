class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, length: {minimum: 6}

  has_secure_password

  has_many :posts
  has_many :likes

  has_many :follower_users, class_name: 'Follow', foreign_key: 'follower_user_id'
  has_many :followee_users, class_name: 'Follow', foreign_key: 'followee_user_id'

  #This function will return array of posts of the users followed by this user (sort from latest to oldest)
  def get_feed_posts
    posts = []

    following_users = self.get_following_users
    following_users.each do |user|
      posts.concat(user.posts)
    end

    posts.sort_by!(&:created_at)
    posts.reverse!()
    return posts
  end

  #Thus function will return array of users followed by this user (sort from latest to oldest)
  def get_following_users
    following_users = []

    #sort follow from latest
    follows = self.follower_users
    follows = follows.sort_by(&:updated_at)
    follows = follows.reverse()

    follows.each do |follow|
      following_users.push(follow.followee_user)
    end

    return following_users
  end

end