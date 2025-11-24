class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
before_action :redirect_if_seller, only: [:index, :create]
before_action :redirect_if_sold_out, only: [:index, :create]
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
        amount: @item.price,
        card: params[:token],  
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

def redirect_if_seller
  if current_user.id == @item.user_id
    redirect_to root_path
  end
end

def redirect_if_sold_out
  if @item.purchase_record.present?
    redirect_to root_path
  end
end

end
