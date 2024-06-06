class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]
  before_action :set_item, only: [:new, :create]
  before_action :authorize_owner!, only: [:edit, :update, :approve, :decline]
  before_action :set_rental_id, only: [:approve, :decline]

  def index
    @pending_rentals = current_user.items.map(&:rentals).flatten.select { |r| r.status == 'pending' }
    @approved_rentals = current_user.items.map(&:rentals).flatten.select { |r| r.status == 'accepted' }
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
    if @rental.update(status: 'declined')
      redirect_to rentals_path, notice: 'Rental was successfully declined.'
    else
      redirect_to rentals_path, alert: 'Error declining rental.'
    end
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def set_rental_id
    @rental = Rental.find(params[:rental_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def authorize_owner!
    set_rental
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.owner_of?(@rental.item)
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :status, :item_id)
  end
end
