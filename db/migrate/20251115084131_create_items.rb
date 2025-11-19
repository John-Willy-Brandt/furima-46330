class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.text :explanation, null: false
      t.integer :category_id, null: false
      t.integer :status_id, null: false
      t.integer :delivery_cost_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :delivery_duration_id, null: false
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
