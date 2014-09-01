class TweetsController < ApplicationController

  before_action :authenticate_user!

  def create
    @tweet = current_user.tweets.create(content: params[:tweet])
    flash[:success] = "Successful Tweet!"
    redirect_to :root
  end

  def destroy
    if current_user.id == Tweet.find_by_id(params[:id]).user_id || current_user.moderator == true
      Tweet.destroy(Tweet.find_by_id(params[:id]))
      redirect_to :root
    else
      flash[:alert] = "You are not authorized to remove this tweet"
    end
  end
end
