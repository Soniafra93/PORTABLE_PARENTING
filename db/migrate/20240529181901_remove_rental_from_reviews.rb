class RemoveRentalFromReviews < ActiveRecord::Migration[7.1]
  def change
    remove_reference :reviews, :rental, foreign_key: true
  end
end
