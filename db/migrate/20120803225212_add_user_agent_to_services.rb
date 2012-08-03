class AddUserAgentToServices < ActiveRecord::Migration
  def change
    add_column :services, :user_agent, :string
  end
end
