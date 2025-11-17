class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  # has_one :purchase_record

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_cost
  belongs_to :prefecture
  belongs_to :delivery_duration

  with_options presence: true do
    validates :image
    validates :item_name
    validates :explanation
    validates :price,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 300,
                less_than_or_equal_to: 9_999_999
              }

    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :status_id
      validates :delivery_cost_id
      validates :prefecture_id
      validates :delivery_duration_id
    end
  end
end
