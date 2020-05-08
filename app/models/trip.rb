
class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  def create_trip(passenger)
    # avilable_drivers = Drivers.where(available: true)
    @driver_id = avilable_drivers[0].id
    @date = Date.new.strftime("%Y-%d-%m")
    @rating = (1..5).to_a.sample
    @cost = (500..10000).to_a.sample
  end
end


