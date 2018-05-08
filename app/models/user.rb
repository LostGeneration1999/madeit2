class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products
  has_many :comments
  has_many :likes
  has_many :recieved_comments, class_name: Comment, foreign_key: :reply_user_id

  acts_as_taggable #タグ
  acts_as_followable #フォロワー
  acts_as_follower #フォロー
  validates :email, presence: true
  validates :nickname, presence: true
  has_attached_file :avatar,
                      styles:  { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :avatar,
                                      content_type: ["image/jpg","image/jpeg","image/png"]
  acts_as_ordered_taggable_on :skills


end
