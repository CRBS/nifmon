class AddApiFormatToServices < ActiveRecord::Migration
  def change
    add_column :services, :api_format, :string
  end
end
