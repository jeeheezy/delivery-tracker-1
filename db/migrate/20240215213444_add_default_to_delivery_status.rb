class AddDefaultToDeliveryStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default :deliveries, :status, from: nil, to: "waiting"
  end
end
