require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    user = User.create(
      first_name: "Frank",
      last_name: "Zhou",
      email: "frank@tank.com",
      password: "password",
      password_confirmation: "password"
    )
  end
    
  describe 'Validations' do
    it "should not save without a first name" do
      user = User.create(
          first_name: nil,
          last_name: "test",
          email: "test@test.com",
          password: "password",
      )
      expect(user).to_not be_valid
    end

    
    it "should not save without a last name" do
      user = User.create(
        first_name: "Frank",
        last_name: nil,
        email: "test@test.com",
        password: "password",
      )
      expect(user).to_not be_valid
    end

    it "should not save without a email" do
      user = User.create(
        first_name: "Frank",
        last_name: "test",
        email: nil,
        password: "password",
      )
      expect(user).to_not be_valid
    end


    it "should not save without a password" do
      user = User.create(
        first_name: "Frank",
        last_name: "test",
        email: "test@test.com",
        password: nil,
      )
      expect(user).to_not be_valid
    end

    it "should not save without matching passwords" do
      user = User.create(
        first_name: "Frank",
        last_name: "test",
        email: "test@test.com",
        password: "password",
        password_confirmation: "Password",
      )
      expect(user).to_not be_valid
    end

    it "should not save if the email exists" do
      user1 = User.create(
        first_name: "Frank",
        last_name: "test",
        email: "test@test.com",
        password: "password",
      )
      user1.save

      user2 = User.create(
        first_name: "Frank",
        last_name: "test",
        email: "test@test.com",
        password: "password",
      )
      
      expect(user2).to_not be_valid
    end

    it "should not have a password under 8 characters" do
      user = User.create(
        first_name: "Frank",
        last_name: "test",
        email: "test@test.com",
        password: "z",
      )

      expect(user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "should return user if email and password is correct" do
      user = User.authenticate_with_credentials("frank@tank.com", "password")

      expect(user).to be_instance_of User
    end
    
    it "should return user even if case is wrong" do
      user = User.authenticate_with_credentials("FRANK@tank.com", "password")

      expect(user).to be_instance_of User
    end
    
    it "should return user even if there are empty spaces" do
      user = User.authenticate_with_credentials("    frank@tank.com     ", "password")

      expect(user).to be_instance_of User
    end
    
    it "should return nil if email and password is correct" do
      user = User.authenticate_with_credentials("frank@tank.com", "blah")

      expect(user).to be_nil
    end
  end
end
