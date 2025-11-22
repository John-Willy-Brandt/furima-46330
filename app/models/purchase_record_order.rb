class PurchaseRecordOrder
  include ActiveModel::Model
  # order + purchase_record が同時に入ってくる
  attr_accessor :user_id, :item_id,
                :zipcode, :prefecture_id, :city, :address, :building_name, :tel,
                :token

  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :zipcode
    validates :prefecture_id
    validates :city
    validates :address
    validates :tel
    validates :token
  end

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
