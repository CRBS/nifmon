class RemoveValidFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :valid
  end

  def down
    add_column :categories, :valid, :boolean
  end
end
