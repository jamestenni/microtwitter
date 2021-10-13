class Post < ApplicationRecord
  validates :msg, presence: true

  belongs_to :user
end
