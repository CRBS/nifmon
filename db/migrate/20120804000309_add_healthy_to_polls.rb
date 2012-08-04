class AddHealthyToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :healthy, :boolean
  end
end
