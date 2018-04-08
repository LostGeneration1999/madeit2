class UsersController < ApplicationController

  def show
    @nickname = current_user.nickname
    @user = User.find(params[:id])
# @tweets = Tweet.where(user_id: current_user.id).page(params[:page]).per(5).order("created_at DESC")
  end

  def setting
  end
end
