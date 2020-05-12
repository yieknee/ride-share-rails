require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passengers saved" do
      passenger1 = Passenger.create(name: 'Earl', phone_num: '1234567')
      passenger2 = Passenger.create(name: 'Bob', phone_num: '9876543')
      # Act
      get(passengers_path)
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      Passenger.delete_all
      # Act
      get(passengers_path)
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      passenger = Passenger.create(name: 'Bob', phone_num: '1234567')
      # Act
      get(passenger_path(passenger.id))
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no passenger
      
      # Act
      get(passenger_path(123124124))
      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get(new_passenger_path)
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      
      expect{post(passengers_path, params: {passenger:{name: 'Bob', phone_num: '1234567'}})}.must_differ 'Passenger.count', 1
      must_respond_with :redirect
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with rendering new form again" do
      
      get(new_passenger_path)
     
      expect{post(passengers_path, params: {passenger:{name: 'Bob'}})}.wont_change 'Passenger.count'
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      passenger = Passenger.create(name: 'Bob', phone_num: '1234567')
      # Act
      get(edit_passenger_path(passenger.id))
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Act
      get(edit_passenger_path(123124213))
      # Assert
      must_respond_with :redirect

    end
  end

  describe "update" do
    before do
      Passenger.create(name: "tom", phone_num: "1234567")
    end
    let (:new_passenger_hash) {
      {
        passenger: {
          name: "bob",
          phone_num: "98765431",
        },
      }
    }
    it "can update an existing passenger with valid information accurately, and redirect" do
      id = Passenger.first.id
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change "Passenger.count"
  
      must_respond_with :redirect
  
      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal new_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]
      

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      get(edit_passenger_path(13421431))
      # Act-Assert
      patch(passenger_path({passenger:{name: 'Bob', phone_num: '9876543'}}))
      # Assert
      must_respond_with :not_found
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Arrange
      passenger = Passenger.create(name: 'Bob', phone_num: '1234567')
      get(edit_passenger_path(passenger.id))
      # Act-Assert
      patch(passenger_path({passenger:{name: 'Bob'}}))
      # Assert
      passenger.phone_num.must_equal '1234567'
      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      passenger = Passenger.create(name: 'Bob', phone_num: '1234567')
      # Act-Assert
      # Assert
      expect {delete(passenger_path(passenger.id)) }.must_differ 'Passenger.count', -1
      must_respond_with :redirect
    end

    it "does not change the db when the passenger does not exist, then responds with " do
      # Arrange
      passenger = Passenger.create(name: 'Bob', phone_num: '1234567')
      # Act-Assert
      # Assert
      expect {delete(passenger_path(143256)) }.must_differ 'Passenger.count', 0
      must_respond_with :redirect
    end
  end
end
