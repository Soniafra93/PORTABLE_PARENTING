class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy, :approve, :decline]
  before_action :authorize_owner!, only: [:edit, :update, :approve, :decline]

  def index
    @owner_rentals = current_user.items.map(&:rentals).flatten
    @pending_rentals = @owner_rentals.select { |rental| rental.status == 'pending' }
    @approved_rentals = @owner_rentals.select { |rental| rental.status == 'accepted' }

    @renter_rentals = current_user.rentals
  end

  def show
  end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.user = current_user
    @rental.item = @item

    if @rental.save
      redirect_to rentals_path, notice: 'Rental was successfully created and is pending approval.'
    else
      render :new
    end
  end

  def edit
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

  def approve
    @rental.update(status: 'accepted')
    redirect_to @rental, notice: 'Rental was approved.'
  end

  def decline
    @rental.update(status: 'declined')
    redirect_to @rental, notice: 'Rental was declined.'
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def authorize_owner!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.owner_of?(@item)
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :status, :item_id)
  end
end
