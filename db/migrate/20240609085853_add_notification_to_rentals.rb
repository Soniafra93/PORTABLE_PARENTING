class AddNotificationToRentals < ActiveRecord::Migration[7.1]
  def change
    add_column :rentals, :notification, :text
  end
end
