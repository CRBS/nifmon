class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.text :response_text
      t.integer :response_time
      t.boolean :success

      t.references :service
      t.timestamps
    end
  end
end
