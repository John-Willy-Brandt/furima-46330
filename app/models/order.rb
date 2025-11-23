class Order < ApplicationRecord

belongs_to :purchase_record
attr_accessor :token
end
