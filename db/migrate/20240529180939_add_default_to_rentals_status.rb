class AddDefaultToRentalsStatus < ActiveRecord::Migration[7.1]
  def change
    change_column :rentals, :status, :string, default: "pending", null: false
  end
end
