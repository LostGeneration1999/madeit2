class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])
    #create時に生成するインスタンス
    @like = Like.find_by(user_id: current_user.id)
    @nickname = @user.nickname
    @products = Product.where(user_id: @user.id).page(params[:page]).per(5).order("created_at DESC")
  end
end
