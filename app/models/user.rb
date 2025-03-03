class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable, :confirmable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments
  has_many :bookmarks
  has_many :bookmarked_posts, through: :bookmarks, source: :post
  has_one_attached :avatar
    # Followed users (users that the current user follows)
    has_many :follows, foreign_key: :follower_id, dependent: :destroy
    has_many :following, through: :follows, source: :followed
  
    # Followers (users who follow the current user)
    has_many :reverse_follows, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy
    has_many :followers, through: :reverse_follows, source: :follower


  validates :name, presence: true, length: { maximum: 20 }
  validates :gender, inclusion: { in: [ "male", "female", "other" ], message: "%{value} is not a valid gender" }, allow_nil: true
  validates :birthday, presence: true, allow_nil: true
  validates :location, length: { maximum: 100 }
  # validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  
   # Methods for following and unfollowing
   def follow(user)
    following << user unless self == user || following.include?(user)
  end

  def unfollow(user)
    following.delete(user)
  end

  # Check if a user is following another user
  def following?(user)
    following.include?(user)
  end
end
