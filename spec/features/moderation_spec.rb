require 'rails_helper'

feature 'Moderation' do
  it 'lets moderators remove tweets' do
    mod = create :moderator
    login mod

    3.times { create :tweet }
    visit root_path

    # Should see 3 tweets
    expect( page.all(".tweet").count ).to eq 3

    first(:link, "Delete Tweet").click

    # Should see 2 tweets
    expect( page.all(".tweet").count ).to eq 2

    # Shouldn't see the one we deleted?
    #   ... ?
  end

  it 'does not let regular users remove tweets' do
    # Regular user doesn't see delete tweet button
    # Even direct posts can't delete
    #   post delete_tweet_path(...)
    #   => should set response
    user = create :user
    login user

    tweet = create :tweet
    page.driver.submit :delete, "/tweets/#{tweet.id}", {}
    expect( Tweet.find tweet.id ).to be_present
  end
end
