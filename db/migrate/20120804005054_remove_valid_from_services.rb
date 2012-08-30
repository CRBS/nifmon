class RemoveValidFromServices < ActiveRecord::Migration
  def up
    remove_column :services, :valid
  end

  def down
    add_column :services, :valid, :boolean
  end
end
