class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :uri
      t.text :description
      t.string :expectation
      t.integer :poll_interval
      t.datetime :last_poll
      t.boolean :valid

      t.timestamps
    end
  end
end
