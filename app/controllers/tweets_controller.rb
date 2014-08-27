class TweetsController < ApplicationController
  before_action :require_session, except: [:index]

  def index
    @tweet = Tweet.new
    @tweets = Tweet.ordered
  end

  def show
  end

  def create
    @tweet = current_user.tweets.new post_params
    if @tweet.save!
      redirect_to root_path, :flash => {:success => "Successful"}
    else
      redirect_to :back
    end
  end

  def new
    @tweet = Tweet.new
  end

  def update
  end

  def edit
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    # unless can? :delete, @tweet
    #   ... raise an authorization error
    authorize! :delete, @tweet

    @tweet.destroy!
    redirect_to root_path, :flash => {:success => "Tweet was removed"}
  end

  private

  def post_params
    params.require(:tweet).permit(:content)
  end

  def require_session
    if current_user == nil
      redirect_to new_user_session_path
    end
  end
end
