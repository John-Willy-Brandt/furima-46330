class PurchaseRecord < ApplicationRecord
  belongs_to :item
  belongs_to :user #←ここにアソシエーションを記載しているつもり。
  has_one :order
end
