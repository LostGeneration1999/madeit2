class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments
  has_many :likes , dependent: :destroy #削除されると自動的にいいねは消える
  has_many :like_users, through: :likes, source: :user #他ー他関係であるので区別化してる？
  # acts_as_ordered_taggable_on :fields  # field.tags_list が追加される
  acts_as_taggable  # acts_as_taggable_on :tags のエイリアス

  def user_exist?(user)
    like_users.include?(user)
    # いいねしたユーザーのなかにuserがいるかどうか
  end

  # def self.search(keyword)
  #   if keyword
  #     Product.where([' name LIKE? ', "%#{keyword}%"])
  #   else
  #     Product.all
  #   end
  # end


end
