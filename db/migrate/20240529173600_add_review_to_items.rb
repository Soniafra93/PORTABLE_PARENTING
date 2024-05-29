class AddReviewToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :review, foreign_key: true
  end
end
