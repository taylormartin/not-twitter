class StaticPagesController < ApplicationController

  before_action :authenticate_user!

  def home
    @tweets = current_user.homepage_tweets(current_user.id)
  end

end
