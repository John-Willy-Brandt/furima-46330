class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update]

  # 一覧表示,
  def index
    @items = Item.all.order(created_at: :desc)
  end

  # 詳細表示
  def show
    # @item は set_item で取得済み
  end

  # 新規出品フォーム
  def new
    @item = Item.new
  end

  # 新規登録（DBに保存）
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path # トップ（index）に戻る
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集フォーム
  def edit
    # @item は set_item で取得済み
  end

  # 更新処理
  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # move_to_index ですでに「current_user じゃなければ root にリダイレクト」しているので
    # ここではシンプルに destroy だけでもOK
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました。'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless current_user == @item.user
  end

  def item_params
    params.require(:item).permit(
      :item_name, :explanation, :category_id, :status_id,
      :delivery_cost_id, :prefecture_id, :delivery_duration_id,
      :price, :image
    ).merge(user_id: current_user.id)
  end
end
