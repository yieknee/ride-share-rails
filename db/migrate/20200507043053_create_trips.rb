class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.integer :driver_id
      t.integer :passenger_id
      t.date :date
      t.integer :rating
      t.integer :cost

      t.timestamps
    end
  end
end
