class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_seller, only: [:index, :create]
  before_action :redirect_if_sold_out, only: [:index, :create]
  def index
    gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
    @purchase_record_order = PurchaseRecordOrder.new
  end

  def create
    @purchase_record_order = PurchaseRecordOrder.new(order_params)

    if @purchase_record_order.valid?
      pay_item

      @purchase_record_order.save 
      redirect_to root_path
    else
      gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end



  def pay_item
    Payjp.api_key = ENV.fetch('PAYJP_SECRET_KEY', nil)
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

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
    return unless current_user.id == @item.user_id

    redirect_to root_path
  end

  def redirect_if_sold_out
    return unless @item.purchase_record.present?

    redirect_to root_path
  end
end
