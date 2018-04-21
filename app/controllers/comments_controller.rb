class CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
  end

  def create
   Comment.create(comment_params)
    redirect_to controller: :products, action: :index
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :image).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
