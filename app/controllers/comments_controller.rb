class CommentsController < ApplicationController
  def create
    @comment = Comment.create(content: params[:content],product_id: params[:product_id],user_id: current_user.id,
        image: params[:image])
    redirect_to "/products/#{@comment.product.id}"
  end

  private
  def comment_params
    params.permit(:text, :tweet_id, :image)
  end
end
