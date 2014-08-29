class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets, dependent: :destroy

  def user_tweets(id)
    Tweet.where(user_id: id)
  end

  def homepage_tweets(id)
    user_ids = [id]
    Relationship.where(follower_id: id).each { |x| user_ids << x.followed_id }
    Tweet.where(user_id: user_ids).order(created_at: :desc)
  end

  def following(id)
    relationships = Relationship.where(follower_id: id)
    relationships.map { |r| [User.where(id: r.followed_id)[0].email, r.followed_id] }
  end

  def followers(id)
    relationships = Relationship.where(followed_id: id)
    relationships.map { |r| User.where(id: r.follower_id)[0].email }
  end

end
