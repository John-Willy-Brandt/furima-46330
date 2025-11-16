require 'rails_helper'
RSpec.describe Item, type: :model do
  let(:item) { FactoryBot.build(:item) }

  describe '商品出品機能' do
    context '出品できるとき' do
      it '全ての項目が正しければ出品できる' do
        expect(item).to be_valid
      end
    end

    context '出品できないとき' do
      it '商品画像を1枚つけることが必須であること' do
        item.image = nil
        item.valid?
        expect(item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が必須であること' do
        item.item_name = ''
        item.valid?
        expect(item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品の説明が必須であること' do
        item.explanation = ''
        item.valid?
        expect(item.errors.full_messages).to include("Explanation can't be blank")
      end

      it 'カテゴリーの情報が必須であること（idが1だと保存できない）' do
        item.category_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態の情報が必須であること' do
        item.status_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担の情報が必須であること' do
        item.delivery_cost_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Delivery cost can't be blank")
      end

      it '発送元の地域の情報が必須であること' do
        item.prefecture_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数の情報が必須であること' do
        item.delivery_duration_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Delivery duration can't be blank")
      end

      it '価格の情報が必須であること' do
        item.price = nil
        item.valid?
        expect(item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が299円以下では保存できないこと' do
        item.price = 299
        item.valid?
        expect(item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が10,000,000円以上では保存できないこと' do
        item.price = 10_000_000
        item.valid?
        expect(item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '価格は半角数値以外では保存できないこと（全角）' do
        item.price = '３００'
        item.valid?
        expect(item.errors.full_messages).to include('Price is not a number')
      end

      it '価格は英字のみでは保存できないこと' do
        item.price = 'aaa'
        item.valid?
        expect(item.errors.full_messages).to include('Price is not a number')
      end

      it '価格は英数字混合では保存できないこと' do
        item.price = '300a'
        item.valid?
        expect(item.errors.full_messages).to include('Price is not a number')
      end
    end
  end

  describe 'ActiveHash の定義' do
    it 'カテゴリーは11項目（---を含む）であること' do
      expect(Category.all.size).to eq(11)
      expect(Category.find(1).name).to eq('---')
      expect(Category.pluck(:name)).to eq(
        %w[--- メンズ レディース ベビー・キッズ インテリア・住まい・小物 本・音楽・ゲーム おもちゃ・ホビー・グッズ 家電・スマホ・カメラ スポーツ・レジャー ハンドメイド その他]
      )
    end

    it '商品の状態は7項目（---を含む）であること' do
      expect(Status.all.size).to eq(7)
      expect(Status.find(1).name).to eq('---')
      expect(Status.pluck(:name)).to eq(
        %w[--- 新品・未使用 未使用に近い 目立った傷や汚れなし やや傷や汚れあり 傷や汚れあり 全体的に状態が悪い]
      )
    end

    it '配送料の負担は3項目（---を含む）であること' do
      expect(DeliveryCost.all.size).to eq(3)
      expect(DeliveryCost.find(1).name).to eq('---')
      expect(DeliveryCost.pluck(:name)).to eq(
        %w[--- 着払い（購入者負担） 送料込み（出品者負担）]
      )
    end

    it '発送元の地域は48項目（--- + 47都道府県）であること' do
      expect(Prefecture.all.size).to eq(48)
      expect(Prefecture.find(1).name).to eq('---')
    end

    it '発送までの日数は4項目（---を含む）であること' do
      expect(DeliveryDuration.all.size).to eq(4)
      expect(DeliveryDuration.find(1).name).to eq('---')
      expect(DeliveryDuration.pluck(:name)).to eq(
        %w[--- 1〜2日で発送 2〜3日で発送 4〜7日で発送]
      )
    end
  end
end
