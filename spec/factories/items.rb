FactoryBot.define do
  factory :item do
     association :user

    item_name        { 'テスト商品' }
    explanation      { 'テスト商品です。' }
    category_id      { 2 }  # 1 は '---' にしているので 2 以上
    status_id        { 2 }
    delivery_cost_id { 2 }
    prefecture_id    { 2 }
    delivery_duration_id { 2 }
    price            { 300 }

    # 画像のダミー
    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('public/images/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
    end
end
