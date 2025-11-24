FactoryBot.define do
  factory :order do
    zipcode { '123-4567' }
    prefecture_id     { 2 } # 1 は `---`
    city              { '東京都' }
    address           { '1-1' }
    building_name     { '東京ハイツ' } # 任意項目
    tel { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
