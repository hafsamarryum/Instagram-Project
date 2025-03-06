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

   # Users that the current user is following
   has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
   has_many :following, through: :active_follows, source: :followed
 
   # Users that are following the current user
   has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
   has_many :followers, through: :passive_follows, source: :follower


  validates :name, presence: true, length: { maximum: 20 }
  validates :gender, inclusion: { in: [ "male", "female", "other" ], message: "%{value} is not a valid gender" }, allow_nil: true
  validates :birthday, presence: true, allow_nil: true
  validates :location, length: { maximum: 100 }

   # Methods to follow and unfollow
   def follow(other_user)
    active_follows.create(followed_id: other_user.id)
   end

  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end

  # Check if the user is following another user
  def following?(other_user)
    following.include?(other_user)
  end
end
