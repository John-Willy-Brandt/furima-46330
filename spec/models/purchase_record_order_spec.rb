# spec/models/purchase_record_order_spec.rb
require 'rails_helper'

RSpec.describe PurchaseRecordOrder, type: :model do
  before do
    @user  = FactoryBot.create(:user)
    @item  = FactoryBot.create(:item)
    @purchase_record_order = FactoryBot.build(
      :purchase_record_order,
      user_id: @user.id,
      item_id: @item.id
    )
  end

  context '購入できるとき' do
    it '全項目が揃っていれば購入できる' do
      expect(@purchase_record_order).to be_valid
    end

    it 'building_name が空でも購入できる' do
      @purchase_record_order.building_name = ''
      expect(@purchase_record_order).to be_valid
    end
  end

  context '購入できないとき' do
    it 'zipcode が空だと購入できない' do
      @purchase_record_order.zipcode = ''
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include("Zipcode can't be blank")
    end

    it 'zipcode がハイフンを含まないと購入できない' do
      @purchase_record_order.zipcode = '1234567'
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include('Zipcode is invalid. Include hyphen(-)')
    end

    it 'prefecture_id が 1（---）だと購入できない' do
      @purchase_record_order.prefecture_id = 1
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'city が空だと購入できない' do
      @purchase_record_order.city = ''
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include("City can't be blank")
    end

    it 'address が空だと購入できない' do
      @purchase_record_order.address = ''
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include("Address can't be blank")
    end

    it 'tel が空だと購入できない' do
      @purchase_record_order.tel = ''
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include("Tel can't be blank")
    end

    it 'tel が9桁未満だと購入できない' do
      @purchase_record_order.tel = '12345678'
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include('Tel is invalid')
    end

    it 'tel が12桁以上だと購入できない' do
      @purchase_record_order.tel = '123456789012'
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include('Tel is invalid')
    end

    it 'tel にハイフンがあると購入できない' do
      @purchase_record_order.tel = '090-1234-5678'
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include('Tel is invalid')
    end

    it 'token が空だと購入できない' do
      @purchase_record_order.token = ''
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include("Token can't be blank")
    end

    it 'user_id が空だと購入できない' do
      @purchase_record_order.user_id = nil
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include("User can't be blank")
    end

    it 'item_id が空だと購入できない' do
      @purchase_record_order.item_id = nil
      @purchase_record_order.valid?
      expect(@purchase_record_order.errors.full_messages).to include("Item can't be blank")
    end
  end
end
