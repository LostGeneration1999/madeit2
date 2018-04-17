class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @user = User.find(params[:id])
    @products = Product.where(user_id: current_user.id).page(params[:page]).per(5).order("created_at DESC")
  end
end
