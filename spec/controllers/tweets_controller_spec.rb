require 'rails_helper'

describe TweetsController do
  it 'lets non-signed-in users see the index page' do
    # Controller specs DO NOT render by default
    #   so this doesn't cause an error even though it might should
    get :index
    expect( response.status ).to eq 200 # Code for success
  end

  it 'allows a user to post a tweet' do
    # Doing this v should really create a new tweet
    user = create :user
    sign_in user

    before = Tweet.count
    post :create, tweet: { content: "Here's a tweet" }
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

  it 'does not let non-moderators delete others tweets'
end
