class CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id]).destroy
    redirect_to "/products/#{@comment.product.id}"
  end

  def create
   @comment = Comment.create(comment_params)
   # @product = Comment.find_by(product_id: params[:product_id])
    redirect_to "/products/#{@comment.product.id}"
  end


  private
  def comment_params
    comment_params = params.require(:comment).permit(:content, :image,:reply_comment).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
