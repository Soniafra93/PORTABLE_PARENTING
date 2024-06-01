class ReviewsController < ApplicationController
  before_action :set_item

  def new
    @review = Review.new
  end

  def create
    @review = @item.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @item, notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
