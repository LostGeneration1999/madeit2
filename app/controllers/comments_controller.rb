class CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to "/products"
  end

  def create
   Comment.create(comment_params)
   @product = Product.find_by(params[:id])
   #find_byのせいで変なページにいく
    redirect_to "/products"
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :image).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
