class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  def index
    @rentals = current_user.rentals
  end

  def show
  end

  def new
    @rental = Rental.new
    @item = Item.find(params[:item_id])
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.user = current_user
    @item = Item.find(params[:item_id])
    @rental.item = @item

    if @rental.save
      redirect_to rentals_path, notice: 'Rental was successfully created.'
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    if @rental.update(rental_params)
      redirect_to @rental, notice: 'Rental was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @rental.destroy
    redirect_to rentals_path, notice: 'Rental was successfully destroyed.', status: :see_other
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :status, :item_id)
  end
end
