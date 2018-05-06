class CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id]).destroy
    redirect_to "/products/#{@comment.product.id}"
  end

  def create
   @comment = Comment.create(comment_params)
   #find_byのせいで変なページにいく
    redirect_to "/products/#{@comment.product.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :image).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
