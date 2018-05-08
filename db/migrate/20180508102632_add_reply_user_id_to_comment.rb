class AddReplyUserIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :reply_user_id, :int
  end
end
