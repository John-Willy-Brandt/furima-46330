# spec/factories/purchase_record_orders.rb
FactoryBot.define do
  factory :purchase_record_order do
    zipcode       { '123-4567' }
    prefecture_id     { 2 }
    city              { '東京都' }
    address           { '1-1' }
    building_name     { '東京ハイツ' }
    tel      { '09012345678' }
    token             { 'tok_abcdefghijk00000000000000000' }
    # user_id, item_id はテスト側でセットします
  end
end
