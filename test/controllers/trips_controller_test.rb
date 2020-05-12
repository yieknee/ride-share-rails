require "test_helper"

describe TripsController do
  describe "show" do
    # # Arrange
    # passenger = Trips.create(driver_id: '1', passenger_id: '2')
    # # Act
    # get(passenger_path(passenger.id))
    # # Assert
    # must_respond_with :success
  end

  describe "create" do 

    it "trip increase by one and redirects" do
    passenger = Passenger.create!(name: "bob", phone_num:"12334556")
    driver = Driver.create!(name: "tom", vin:"asdfghjkl", available: true)
      
    expect{post passenger_trips_path(passenger.id)}.must_differ "Trip.count", 1
    must_redirect_to passenger_path(passenger.id)
    end
  end

  describe "edit" do

  # let (:new_trip_hash) {
  #   {
  #     driver: {
  #       rating: "3",
  #     },
  #   }
  # }
  #   it "trip edits rating" do
  #     trip = Trip.create
        
  #     expect {
  #       patch trip_path(id), params: new_trip_hash
  #     }.wont_change "Trip.count"
  
  #     must_respond_with :redirect
  
  #     trip = Trip.find_by(id: id)
  #     expect(trip.rating).must_equal new_trip_hash[:trip][:rating]
      
  # end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
