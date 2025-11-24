require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

 context '購入できるとき' do
    it '全項目が揃っていれば購入できる' do
      expect(@order).to be_valid
    end

    it 'building_name が空でも購入できる' do
      @order.building_name = ''
      expect(@order).to be_valid
    end
  end

  context '購入できないとき' do
    it 'postal_code が空だと購入できない' do
      @order.zipcode = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_code がハイフンを含まないと購入できない' do
      @order.zipcode = '1234567'
      @order.valid?
      expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it 'prefecture_id が 1（---）だと購入できない' do
      @order.prefecture_id = 1
      @order.valid?
      expect(@order.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'city が空だと購入できない' do
      @order.city = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end

    it 'address が空だと購入できない' do
      @order.address = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Address can't be blank")
    end

    it 'phone_number が空だと購入できない' do
      @order.tel = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_number が9桁未満だと購入できない' do
      @order.tel = '12345678'
      @order.valid?
      expect(@order.errors.full_messages).to include('Phone number is invalid')
    end

    it 'phone_number が12桁以上だと購入できない' do
      @order.tel = '123456789012'
      @order.valid?
      expect(@order.errors.full_messages).to include('Phone number is invalid')
    end

    it 'phone_number にハイフンがあると購入できない' do
      @order.tel = '090-1234-5678'
      @order.valid?
      expect(@order.errors.full_messages).to include('Phone number is invalid')
    end

    it 'token が空だと購入できない' do
      @order.token = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end

    it 'user_id が空だと購入できない' do
      @order.user_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("User can't be blank")
    end

    it 'item_id が空だと購入できない' do
      @order.item_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Item can't be blank")
    end
  end
end

