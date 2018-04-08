class CreateThemetags < ActiveRecord::Migration
  def change
    create_table :themetags do |t|

      t.timestamps null: false
    end
  end
end
