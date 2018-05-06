class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :top]

  def top
    @trend = ActsAsTaggableOn::Tag.most_used(3)
  end

  def index
    @products = Product.order("created_at DESC").page(params[:page]).per(10)
    if user_signed_in?

    #create時に生成するインスタンス
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])

    #destroy時にテーブルから探し出す
    @like = Like.find_by(user_id: current_user.id)

    @tag =  User.find(current_user.id).tag_list
    @tag_products = []
      @tag.each do |a_tag|
        @tag_products << Product.tagged_with(a_tag)
      end
    end
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
    if user_signed_in?
    @like = Like.find_by(user_id: current_user.id)
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])
    @like_list = Like.find_by(product_id: params[:product_id])
    @comments = Comment.new
    end
  end

  def search
    @like = Like.find_by(user_id: current_user.id)
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])
    @search = Product.ransack(params[:q])
    @results = @search.result.order("created_at DESC").page(params[:page]).per(10)

    @tag_search = Product.tagged_with(params[:search])
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