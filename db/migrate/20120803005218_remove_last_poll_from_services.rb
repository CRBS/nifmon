class RemoveLastPollFromServices < ActiveRecord::Migration
  def up
    remove_column :services, :last_poll
  end

  def down
    add_column :services, :last_poll, :datetime
  end
end
