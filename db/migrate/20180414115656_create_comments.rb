class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :product_id
      t.text :content
      t.string :image
      t.timestamps
    end
  end
end
