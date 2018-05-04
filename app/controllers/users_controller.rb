class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])

    #create時に生成するインスタンス
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])

    #destroy時に必要とするインスタンス
    @like = Like.find_by(user_id: current_user.id)

    @nickname = @user.nickname

    #対象ユーザー様がlikesを表示する時に必要なインスタンス
    @like_user = Like.where(user_id: @user.id).product

    @like_products = @like.product

    #対象ユーザー様が投稿したツイートを表示
    @products = Product.where(user_id: @user.id).page(params[:page]).per(3).order("created_at DESC")
  end
end
