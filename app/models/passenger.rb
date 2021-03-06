class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify

  def total_charged
    trips_with_passenger_id = self.trips.where(passenger_id: id)

    sum = 0

    trips_with_passenger_id.each do |trip|
      sum += trip.cost
    end
    
    return "$#{'%.2f' % (sum/100.00)}"
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :phone_num, presence: true#, format: /\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})/
  
end
