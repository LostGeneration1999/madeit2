class Likes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :product_id, null: false

      t.timestamps

      t.index :user_id
      t.index :product_id
      t.index [:user_id, :product_id] , unique: true
    end
  end
end
