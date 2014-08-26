class Tweet < ActiveRecord::Base

  belongs_to :user


  def author(tweet)
    users_id = tweet[:user_id]
    user = User.find(users_id)
    user[:email]
  end

  def self.ordered
    Tweet.all.order('created_at DESC')
  end

end
