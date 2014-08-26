require 'rails_helper'

feature 'Moderation' do
  it 'lets moderators remove tweets' do
    mod = create :moderator
    login mod

    3.times { create :tweet }
    visit root_path

    # Should see 3 tweets
    expect( page.all(".tweet").count ).to eq 3

    click_on "Delete Tweet", match: :first

    # Should see 2 tweets
    expect( page.all(".tweet").count ).to eq 2

    # Shouldn't see the one we deleted?
    #   ... ?
  end

  pending 'does not let regular users remove tweets' do
    # Regular user doesn't see delete tweet button
    # Even direct posts can't delete
    #   post delete_tweet_path(...)
    #   => should set response
    user = create :user
    login user

    tweet = create :tweet
    delete tweet_path(tweet)
    expect( Tweet.find tweet.id ).to be_present
  end
end
