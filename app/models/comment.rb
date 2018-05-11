class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def self.reply_show(comment)
    Comment.find_by(id: comment.reply_comment).user
  end
end
