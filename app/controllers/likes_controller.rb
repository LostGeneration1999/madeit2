class LikesController < ApplicationController
  def create
    Like.create(like_params)


    redirect_to controller: :products, action: :index
    # product_idはネストしているのでproduct_idのデータが@likeに添加されている？
    # ん？待てよ？これってproduct_controllerからやっちゃいかんの？　-> ルーティングでこのアクションまで飛んでるのでだめ
    # データベースにuserのidを含んだ情報を保存
    # 新たにLikeするツイートのidを取ってきている
    # current_userの情報を引数に入れて、Likeしたuserとしてデータベースに保存
  end

  def destroy
    @like_product = Like.find(params[:id]).product
    # いいねされたツイートのidを取得してのそツイートの情報を取得

    Like.find_by(user_id: current_user.id, product_id: params[:product_id]).destroy
    # すでにLike!されているツイートのidを取得してその現在のユーザーがしたいいね！を削除
    #
    redirect_to controller: :products, action: :index
  end

  private
  def like_params
    params.permit(:product_id).merge(user_id: current_user.id)
  end
end
