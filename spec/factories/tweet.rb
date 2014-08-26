FactoryGirl.define do
  factory :tweet do
    content "@omniscient_bob yo"
    user
  end
end

# `create :tweet` creates a new user to own tweet
#
# u = create :user
# create :tweet, user: u
# ^- create a new tweet owned by `u`
