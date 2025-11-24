class PurchaseRecordOrder
  include ActiveModel::Model
  # order + purchase_record が同時に入ってくる
  attr_accessor :user_id, :item_id,
                :zipcode, :prefecture_id, :city, :address, :building_name, :tel,
                :token

  # バリデーション
  # 必須項目（presence: true）のグループ
  with_options presence: true do
    validates :zipcode, format: { with: /\A\d{3}-\d{4}\z/,
                                  message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :token
    validates :address
    validates :tel, format: { with: /\A\d{10,11}\z/,
                              message: 'is invalid' }
    validates :user_id
    validates :item_id

  end

  # ActiveHash の「---」(id:1) を選ばせない
  validates :prefecture_id,
            numericality: { other_than: 1, message: "can't be blank" }

  validates :tel,
            format: { with: /\A\d{10,11}\z/,
                      message: 'is invalid' }

  # 保存処理（2つのテーブルにまたがる）
  def save
    # 1. 購入履歴テーブルに登録
    purchase_record = PurchaseRecord.create(
      user_id: user_id, item_id: item_id
    )

    # 2. 住所テーブルに登録
    Order.create(
      zipcode: zipcode,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building_name: building_name,
      tel: tel,
      purchase_record_id: purchase_record.id
    )
  end
end
