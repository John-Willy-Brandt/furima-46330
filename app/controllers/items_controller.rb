class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path # トップ（index）に戻る
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました。'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    return unless current_user != @item.user || @item.purchase_record.present?

    redirect_to root_path
  end

  def item_params
    params.require(:item).permit(
      :item_name, :explanation, :category_id, :status_id,
      :delivery_cost_id, :prefecture_id, :delivery_duration_id,
      :price, :image
    ).merge(user_id: current_user.id)
  end
end
