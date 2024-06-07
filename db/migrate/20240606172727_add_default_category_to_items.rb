class AddDefaultCategoryToItems < ActiveRecord::Migration[7.1]
  def up
    Item.where(category: nil).update_all(category: "Miscellaneous")
  end

  def down
    # I can choose to leave this empty or revert the category to nil if necessary
  end
end
