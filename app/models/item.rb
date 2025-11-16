class Item < ApplicationRecord

belongs_to :user
has_one_attached :image
has_one :purchase_record

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_cost
  belongs_to :Prefecture
  belongs_to :delivery_duration

    with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :price,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 300,
                less_than_or_equal_to: 9_999_999
              }

    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :status_id
      validates :shipping_fee_status_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
  end
end
