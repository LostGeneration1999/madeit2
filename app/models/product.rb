class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments
  has_many :likes , dependent: :destroy #削除されると自動的にいいねは消える
  has_many :like_users, through: :likes, source: :user #他ー他関係であるので区別化してる？

  def like(user)
    Like.create(user_id: user)
    # product_idは@likeにデータが添加されているのだろう
    # データベースにuserのidを含んだ情報を保存
    # なぜモデルに書くのか？
  end

  def unlike(user)
    Like.find_by(user_id: user).destroy
  end

  def user_exist?(user)
    like_users.include?(user)
  end

  # acts_as_ordered_taggable_on :fields  # field.tags_list が追加される
  acts_as_taggable  # acts_as_taggable_on :tags のエイリアス
end
