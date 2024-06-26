class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Item.distinct.pluck(:category)
    @items = if params[:category].present? && params[:category] != "All"
               Item.where(category: params[:category]).available_for_rent
             else
               Item.available_for_rent
             end
  end

  def search
    if params[:query].present?
      @items = Item.search_by_name_and_description(params[:query])
    else
      @items = Item.all
    end
    @categories = Item.distinct.pluck(:category)
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
