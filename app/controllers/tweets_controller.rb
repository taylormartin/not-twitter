class TweetsController < ApplicationController

  before_action :authenticate_user!

  def create
    @tweet = current_user.tweets.create(content: params[:tweet])
    flash[:success] = "Successful Tweet!"
    redirect_to :root
  end

  def destroy
    #need to add security measures here
    Tweet.destroy(Tweet.find_by_id(params[:id]))
    redirect_to :root
  end

end
