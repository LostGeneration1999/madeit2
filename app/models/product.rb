class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user

  acts_as_ordered_taggable_on :fields  # product.tags_list が追加される
  # acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
end
