require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "saves with valid attributes" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user.save
      expect(@user).to be_valid
    end
    it "won't save without matching password fields" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "passwor")
      @user.save
      expect(@user.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
    end
    it "email must be unique" do
      @user1 = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user2 = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user1.save
      @user2.save
      expect(@user1).to be_valid
      expect(@user2.errors.full_messages).to eq(["Email has already been taken"])
    end
    it "email must be unique (case insensitive)" do
      @user1 = User.new(name: "John Smith", email: "johnSMITH@gmail.com", password: "password", password_confirmation: "password")
      @user2 = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user1.save
      @user2.save
      expect(@user1).to be_valid
      expect(@user2.errors.full_messages).to eq(["Email has already been taken"])
    end
    it "password minimum length of 5" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "pass", password_confirmation: "pass")
      @user.save
      expect(@user.errors.full_messages).to eq(["Password is too short (minimum is 5 characters)"])
    end
    it "won't save without name" do
      @user = User.new(name: nil, email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq(["Name can't be blank"])
    end
    it "won't save without email" do
      @user = User.new(name: "John Smith", email: nil, password: "password", password_confirmation: "password")
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq(["Email can't be blank"])
    end
    it "won't save without password confirmation" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: nil)
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq(["Password confirmation can't be blank"])
    end
  end

  describe '.authenticate_with_credentials' do
    it "should return a user" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user.save
      @user_auth = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@user_auth).to_not be_nil
    end
    it "should be nil if email empty" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user.save
      @user_auth = User.authenticate_with_credentials(nil, @user.password)
      expect(@user_auth).to be_nil
    end
    it "should be nil if password empty" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user.save
      @user_auth = User.authenticate_with_credentials(@user.email, nil)
      expect(@user_auth).to be_nil
    end
    it "should be nil if password incorrect" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user.save
      @user_auth = User.authenticate_with_credentials(@user.email, "passwor")
      expect(@user_auth).to be_nil
    end
    it "should be nil if email incorrect" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user.save
      @user_auth = User.authenticate_with_credentials("johnsmith@gmail.co", @user.password)
      expect(@user_auth).to be_nil
    end
    it "should return a user is trailing spaces in email" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user.save
      @user_auth = User.authenticate_with_credentials("   johnsmith@gmail.com   ", @user.password)
      expect(@user_auth).to_not be_nil
    end
    it "should return a user if wrong case in email used" do
      @user = User.new(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user.save
      @user_auth = User.authenticate_with_credentials("johnSMITH@gmail.com", @user.password)
      expect(@user_auth).to_not be_nil
    end
  end
end
