require "test_helper"

describe TripsController do
  describe "show" do

    it "shows a trip" do
      # Arrange
      passenger = Passenger.create!(name: "bob", phone_num:"12334556")
      driver = Driver.create!(name: "tom", vin:"asdfghjkl", available: true)
      trip = Trip.new_trip(passenger, driver)
      # Act
      get(trip_path(trip.id))
      # Assert
      must_respond_with :success
    end
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

    let (:new_trip_hash) {
      {
        driver: {
          rating: "3",
        },
      }
    }
    it "trip edits rating" do
      trip = Trip.create(id: 1, driver_id: 1, passenger_id: 2, date: Date.today, cost: 1234, rating:1)
      id = Trip.first.id
      p id
      expect {
        patch(trip_path(id), params: new_trip_hash)
      }.wont_change "Trip.count"
      p trip
  
      # must_respond_with :redirect
  
      updated_trip = Trip.find_by(id)
      p updated_trip
      expect(updated_trip.rating).must_equal new_trip_hash[:trip][:rating]
    end
        
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
