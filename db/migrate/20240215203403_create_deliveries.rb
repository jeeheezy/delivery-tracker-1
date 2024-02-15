class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.integer :user_id
      t.string :description
      t.date :supposed_arrival_date
      t.string :details
      t.string :status

      t.timestamps
    end
  end
end
