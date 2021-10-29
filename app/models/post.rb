class Post < ApplicationRecord
  validates :msg, presence: true

  has_many :likes

  belongs_to :user

  def get_liked_users
    liked_users = []
    self.likes.each do |like|
      liked_users.push(like.user.name)
    end
    return liked_users
  end

end
