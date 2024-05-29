class RemoveReviewFromItem < ActiveRecord::Migration[7.1]
  def change
    remove_reference :items, :review, foreign_key: true
  end
end
