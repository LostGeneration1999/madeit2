class AddNicknameToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :field, :string
    add_column :users, :twitter_id, :string
    add_column :users, :facebook_id, :string
    add_column :users, :github_id, :string
    add_column :users, :birth, :string
  end
end
