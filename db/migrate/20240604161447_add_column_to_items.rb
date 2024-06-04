class AddColumnToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :Address, :string
  end
end
