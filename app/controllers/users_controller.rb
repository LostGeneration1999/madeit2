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
    @user_like = Like.where(user_id: @user.id).index_by(&:product_id).keys
    @user_like_products = Product.includes(:user,:like_users,:taggings).where(id: @user_like).take(10)

    unless @like.nil?
      @like_products = @like.product
    end

    #対象ユーザー様が投稿したツイートを表示
    @products = Product.includes(:user,:like_users,:taggings).where(user_id: @user.id).page(params[:page]).per(5).order("created_at DESC")
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.stop_following(@user)
  end
end
