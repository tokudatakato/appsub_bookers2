class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def follower
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
  def followed
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
end
