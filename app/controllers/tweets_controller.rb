class TweetsController < ApplicationController

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

  def delete
  end

  private

  def post_params
    params.require(:tweet).permit(:content)
  end
end
