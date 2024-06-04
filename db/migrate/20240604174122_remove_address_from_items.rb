class RemoveAddressFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :Address
  end
end
