
class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  def self.new_trip(passenger_id, driver)
    trip = Trip.new(
    driver_id: driver.id,
    passenger_id: passenger_id,
    date: Date.today.strftime("%Y-%d-%m"),
    cost: (500..10000).to_a.sample
    )
    return trip
  end
end


