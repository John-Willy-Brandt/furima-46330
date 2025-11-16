require 'rails_helper'
RSpec.describe Item, type: :model do

 let(:item) { FactoryBot.build(:item) }

  describe '商品出品機能' do
    context '出品できるとき' do
      it '全ての項目が正しければ出品できる' do
        expect(item).to be_valid
      end
    end




end
