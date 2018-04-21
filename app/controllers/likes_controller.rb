class LikesController < ApplicationController
  def create
    @product_like = Product.find(params[:id])
    @product_like.like(current_user)
    # 新たにLikeするツイートのidを取ってきている
    # current_userの情報を引数に入れて、Likeしたuserとしてデータベースに保存
  end

  def destroy
    @product_like = Like.find(params[:id]).product
    # すでにLike!されているツイートのidを取得してその対象ツイートを取得
    @product_like.unlike(current_user)
  end
end
