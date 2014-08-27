class Tweet < ActiveRecord::Base

  validates_presence_of :user_id, :content
  belongs_to :user


  def author

    user[:email]
  end

  def self.ordered
    Tweet.all.order('created_at DESC')
  end

end
