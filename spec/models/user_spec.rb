require 'rails_helper'

describe User, :type => :model do
  let!(:user_1) { FactoryGirl.create(:user, user_name: 'alice', password: 'd7hk2331') }
  let!(:user_2) { FactoryGirl.create(:user) }

  describe 'create_user - When signing up for an existing user' do
    it 'should check if user is already existed and return false' do
      expect(User.create_user('alice', '732hjk283')).to eq(false)
    end
  end

  describe 'create_user - When signing up for a new user' do
    it 'should return true if db does not contain this user' do
      expect(User.create_user('bob', '732hjk283')).to eq(true)
    end
  end

  describe "validate_user - When user wants to sign in with correct password" do
    it 'should return nothing to indicate correct behavior' do
      expect(User.validate_user('fake_username', 'aaaaaa')).to eq('')
    end
  end

  describe "validate_user - When user wants to sign in with incorrect password" do
    it 'should return a message to indicate user entered wrong password' do
      expect(User.validate_user('fake_username', 'aaabbb')).to eq('Incorrect username or password')
    end
  end

  describe "validate_user - When user wants to sign in without signing up yet" do
    it 'should return a message to indicate user has not created account yet' do
      expect(User.validate_user('bob', 'aaabbb')).to eq('User name does not exist')
    end
  end
end