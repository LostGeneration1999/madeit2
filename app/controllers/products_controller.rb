class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :top]

  def top
  end

  def index
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])
    #create時に生成するインスタンス
    @like = Like.find_by(user_id: current_user.id)
    #destroy時にテーブルから探し出す
    @products = Product.order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(name: product_params[:name], content: product_params[:content],
                               url1: product_params[:url1], url2: product_params[:url2],user_id: current_user.id,
                               image: product_params[:image],description: product_params[:description])
    @product.tag_list.add(product_params[:tag_list], parse: true)
    @product.save
    redirect_to action: :index
  end

  def show
    @product = Product.find(params[:id])
    @like = Like.find_by(user_id: current_user.id)
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])
    @comments = Comment.new
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy if product.user_id ==  current_user.id
    redirect_to action: :index
  end

 private
   # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name,:content, :url1, :url2,:description, :image, :tag_list)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end