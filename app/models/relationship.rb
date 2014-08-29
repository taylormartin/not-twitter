class Relationship < ActiveRecord::Base
  validates_presence_of :follower_id, :followed_id
end
