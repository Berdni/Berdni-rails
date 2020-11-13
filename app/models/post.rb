class Post < ApplicationRecord
  belongs_to :user
  before_save { body.squeeze! }
  validates :body, presence: true, length: { maximum: 200 }
end
