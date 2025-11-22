class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string  :zipcode,        null: false
      t.integer :prefecture_id,  null: false
      t.string  :city,           null: false
      t.string  :address,        null: false
      t.string  :building_name
      t.string  :tel,            null: false
      t.references :purchase_record, null: false, foreign_key: true

      t.timestamps

    end
  end
end
