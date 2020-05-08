class Passenger < ApplicationRecord
  has_many :trips

  def total_charged
    trips_with_passenger_id = self.trips.where(passenger_id: id)

    sum = 0

    trips_with_passenger_id.each do |trip|
      sum += trip.cost
    end

    return sum
  end
  
end
