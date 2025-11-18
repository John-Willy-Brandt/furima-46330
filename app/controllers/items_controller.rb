class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.order(created_at: :desc)

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :item_name,
      :explanation,
      :category_id,
      :status_id,
      :delivery_cost_id,
      :prefecture_id,
      :delivery_duration_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
