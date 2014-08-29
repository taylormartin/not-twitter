class ProfilesController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @tweets = current_user.user_tweets(current_user.id)
    @following = current_user.following(current_user.id)
    @followers = current_user.followers(current_user.id)
  end

  def create
    if Relationship.where(follower_id: current_user.id, followed_id: params[:followed_id]) == []
      r = Relationship.new(follower_id: current_user.id, followed_id: params[:followed_id])
      r.save!
    else
      flash[:notice] = "You already follow this user"
    end
    redirect_to profiles_path
  end

  def destroy
    Relationship.destroy(Relationship.where(follower_id: current_user.id, followed_id: params[:followed_id]))
    redirect_to profile_path(current_user.id)
  end

end
