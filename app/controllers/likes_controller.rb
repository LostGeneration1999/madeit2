class LikesController < ApplicationController
  def create
    @like = Like.create(like_params)
    @product = @like.product
    # redirect_to controller: :products, action: :index
  end

  def destroy
    # いいねされたツイートのidを取得してのそツイートの情報を取得
    @likes = Like.find_by(user_id: current_user.id, product_id: params[:product_id])
    @product = @likes.product
    @likes.destroy
    # すでにLike!されているツイートのidを取得してその現在のユーザーがしたいいね！を削除
  end


  private
  def like_params
    params.permit(:product_id).merge(user_id: current_user.id)
  end
end