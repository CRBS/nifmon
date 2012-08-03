class AddCookiesToServices < ActiveRecord::Migration
  def change
    add_column :services, :cookies, :text
  end
end
