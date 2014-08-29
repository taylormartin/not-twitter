class TweetsController < ApplicationController

  before_action :authenticate_user!

  def create
    @tweet = current_user.tweets.create(content: params[:Tweet])
    flash[:notice] = "Successful Tweet!"
    redirect_to :root
  end

end
