class Bookmark < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user_id, uniqueness: { scope: :post_id, message: "has already bookmarked this post" }
end
