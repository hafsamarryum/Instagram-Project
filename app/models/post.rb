class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :likers, through: :likes, source: :user, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :content, presence: true, length: { maximum: 300 }

  def is_belongs_to?(user)
    self.user_id == user.id
  end


  def liked_by?(user)
    likers.exists?(id: user.id)
  end

  def is_bookmarked(user)
    Bookmark.find_by(user_id: user.id, post_id: id)
  end

  private
  def purge_images
    images.purge_later
  end
end
