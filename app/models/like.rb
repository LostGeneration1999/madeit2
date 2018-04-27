class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates :user_id, presence: true
  validates :product_id, presence: true
  # validates_uniqueness_of :product_id, scope: :user_id
end
