require 'rails_helper'

describe TweetsController do

  it 'allows a user to post a tweet' do
    # Doing this v should really create a new tweet
    user = create :user
    sign_in user

    before = Tweet.count
    post :create, tweet:  "Here's a tweet"

    expect( response.status ).to eq 302
    expect( flash[:success] ).to be_present
    expect( Tweet.count - before ).to eq 1
    # rspec has `expect { }.to change(Tweet, :count) ...`
  end

  it 'lets moderators delete tweets' do
    moderator = create :moderator
    tweet     = create :tweet
    sign_in moderator

    # send `delete` HTTP verb to the `destroy` action
    #   on TweetsController (from describe block)
    #   specifying :id to be the tweet id
    delete :destroy, id: tweet.id
    # expect( Tweet.find_by_id tweet.id ).to eq nil
    expect do
      Tweet.find tweet.id
    end.to raise_error ActiveRecord::RecordNotFound

    # expect do
    #   delete :destroy, id: tweet.id
    # end.to change(Tweet, :count).by 1
  end

  it 'does not let non-moderators delete others tweets' do
    user = create :user
    sign_in user

    # create :tweet, user: user
    # ^- assigns existing user
    # v- creates a new user
    tweet = create :tweet
    # could say `create :tweet, user: create(:user)`

    expect( user.id ).not_to eq tweet.user_id

    request.env["HTTP_REFERER"] = root_path
    delete :destroy, id: tweet.id

    expect( response ).not_to be_successful
    expect( Tweet.find(tweet.id) ).to be_present
  end

  it 'lets users delete their own tweet' do
    user = create :user
    sign_in user
    tweet = create :tweet, user: user

    delete :destroy, id: tweet.id

    expect do
      Tweet.find tweet.id
    end.to raise_error ActiveRecord::RecordNotFound
  end
end
