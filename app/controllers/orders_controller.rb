class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_record_order = PurchaseRecordOrder.new
  end

  def create
    @purchase_record_order = PurchaseRecordOrder.new(order_params)

    if @purchase_record_order.valid?
      pay_item

      @purchase_record_order.save  # purchase_records と orders を保存
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  # 購入対象の商品を取得
  def set_item
    @item = Item.find(params[:item_id])
  end

  # 不正アクセス防止：
  # - 出品者本人は購入できない
  # - すでに売れている商品は購入できない
  def move_to_root
    if current_user == @item.user || @item.purchase_record.present?
      redirect_to root_path
    end
  end

  # Strong Parameters
  def order_params
    params.require(:purchase_record_order).permit(
      :zipcode, :prefecture_id, :city, :address,
      :building_name, :tel
    ).merge(
      user_id: current_user.id,
      item_id: @item.id
      # Payjp 導入時に token を追加予定:
      # , token: params[:token]
    )
  end

   def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: order_params[:price],
        card: order_params[:token],  
        currency: 'jpy'              
      )
   end
  private

def order_params
  params.require(:purchase_record_order).permit(
    :zipcode,
    :prefecture_id,
    :city,
    :address,
    :building_name,
    :tel
  ).merge(
    user_id: current_user.id,
    item_id: params[:item_id],
    token: params[:token]
  )
end



end
