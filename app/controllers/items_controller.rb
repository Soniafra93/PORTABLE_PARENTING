class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.available_for_rent
    @items = @items.where("category ILIKE ?", "%#{params[:category]}%") if params[:category].present?
    @items = @items.search_by_name_and_description(params[:query]) if params[:query].present?
  end

  def show
    @review = Review.new
    @markers = [
      {
        lat: @item.latitude,
        lng: @item.longitude,
        info_window_html: render_to_string(partial: "partials/info_window", locals: {item: @item}),
        marker_html: render_to_string(partial: "partials/marker")
      }
    ]
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :address, :category, photos: [])
  end
end
