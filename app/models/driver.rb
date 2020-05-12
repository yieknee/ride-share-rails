class Driver < ApplicationRecord
  has_many :trips

  def total_earned
    trips_with_driver_id = self.trips.where(driver_id: id)
    total_trips = self.trips.where(driver_id: id).count
    sum = 0

    trips_with_driver_id.each do |trip|
      sum += trip.cost
    end

    fee = 165 * total_trips
    earned = (sum - fee)* 0.8
    earned_in_dollars = earned/100
    return "$#{'%.2f' % earned_in_dollars}"
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

  def self.available_driver
    avilable_drivers = Driver.where(available: true)
    driver = avilable_drivers[0]
    return driver
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :vin, presence: true

end
