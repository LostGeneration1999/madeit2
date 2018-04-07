class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :content
      t.string :url1
      t.string :url2
      t.timestamps
    end
  end
end
