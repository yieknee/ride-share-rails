class Driver < ApplicationRecord
  has_many :trips

  def total_earned
    trips_with_driver_id = self.trips.where(driver_id: id)

    sum = 0

    trips_with_driver_id.each do |trip|
      sum += trip.cost
    end

    return sum
  end

  def average_rating
    trips_with_driver_id = self.trips.where(driver_id: id)

    rating_sum = 0.00
    trips_count = trips_with_driver_id.count

    trips_with_driver_id.each do |trip|
      rating_sum += trip.rating
    end

    answer = rating_sum/trips_count

    return rating_sum == 0 ? 'N/A' : answer.round(2)

  end

  def total_trips
    trips_with_driver_id = self.trips.where(driver_id: id)
    return trips_with_driver_id.count
  end

end
