class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:top]

#likeインスタンスとかもうクラスインスタンスに格上げしていいかも

  def top
    @trend = ActsAsTaggableOn::Tag.most_used(3)
  end

  def index
    #フォローしているユーザーのみタイムラインに表示
    @products_all = Product.includes(:user,:taggings,:like_users,:likes)

    @user = User.find(current_user.id)
    @my_products = @user.products
    @follow_users = @user.all_following
    @products = @products_all.where(user_id: @follow_users).order("created_at DESC").page(params[:page]).per(10)

    #create時に生成するインスタンス
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])

    #destroy時にテーブルから探し出す
    @like = Like.find_by(user_id: current_user.id)

    #自分の登録タグを取得 and タグにまつわるツイートを検索
    @tag =  @user.tag_list
    @tag_products = []
      @tag.each do |a_tag|
        @tag_products << @products_all.tagged_with(a_tag).take(20)
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

    #指定のツイートのコメントを列挙
    @comments = Comment.includes(:user).where(product_id: @product.id)

    @like = Like.find_by(user_id: current_user.id)
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])


    #コメント追加
    @new_comments = Comment.new
  end



  def search
    @like = Like.find_by(user_id: current_user.id)
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])

    # キーワード検索
    @search = Product.ransack(params[:q])
    @results = @search.result.includes(:user,:likes,:taggings,:like_users).order("created_at DESC").page(params[:page]).per(10)

    # タグ検索
    @tag_search = Product.includes(:user,:taggings,:like_users).tagged_with(params[:search])
  end



  def search_tag
    @like = Like.find_by(user_id: current_user.id)
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])
  end



  def ranking
    #いいね機能
    @like = Like.find_by(user_id: current_user.id)
    @likes = Like.new(user_id: current_user.id, product_id: params[:product_id])


    #ランキング機能
    # group(レコード配列)->order(レコード配列)->limit(レコード配列)->count(ハッシュ)
    # いいねの多い順に並び替えた配列
    #
    # この辺同じようなコードを書いているので無駄を消したいなと思ったができなかった


    # いいね数ランキング
    @like_count_id_hash = Like.group(:product_id).order('count_product_id DESC').limit(10).count(:product_id)
    @like_count_id = @like_count_id_hash.keys


    #いいね順にツイートを取得する
    @like_count_product = Product.includes(:user,:likes,:taggings,:like_users).where(id: @like_count_id).index_by(&:id)


    #投稿数ランキング
    @product_count_id_hash = Product.group(:user_id).order('count_user_id DESC').limit(5).count(:user_id)
    @product_count_id = @product_count_id_hash.keys


    #投稿数順にユーザーを取得する
    @product_count_user = User.where(id: @product_count_id).index_by(&:id)


    #フォロワーランキング
    @follow_count_id_hash = Follow.group(:followable_id).order('count_followable_id DESC').limit(5).count(:followable_id)
    @follow_count_id = @follow_count_id_hash.keys


    #フォロワー順にユーザーを取得する
    @follow_count_user = User.where(id: @follow_count_id).index_by(&:id)

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