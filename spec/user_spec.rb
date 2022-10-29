require 'rails_helper'

describe User, :type => :model do
  let!(:user_1) { FactoryGirl.create(:user, user_name: 'alice', password: 'd7hk2331') }

  describe 'When signing up for a new user' do
    it 'should check if user is already existed' do
      expect(User.create_user('alice', '732hjk283')).to eq(false)
    end
  end
end