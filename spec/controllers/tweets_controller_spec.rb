require 'rails_helper'

describe TweetsController do
  it 'lets non-signed-in users see the index page' do
    # Controller specs DO NOT render by default
    #   so this doesn't cause an error even though it might should
    get :index
    expect( response.status ).to eq 200 # Code for success
  end

  skip 'lets moderators delete tweets' do
    moderator = create :moderator
    tweet     = create :tweet

    # send `delete` HTTP verb to the `destroy` action
    #   on TweetsController (from describe block)
    #   specifying :id to be the tweet id
    delete :destroy, id: tweet.id
    binding.pry
  end

  it 'does not let non-moderators delete others tweets'
end
