require 'rails_helper'

describe UsersController, :type => :controller do
  describe "When a new user wants to sign up" do
    it 'should send corresponding request and render signup template' do
      get :signup
      expect(response).to render_template("signup")
    end

    it 'should call model user to create user' do
      post :create, {:user => {:user_name => "fake_user", :password => "872j932"}}
      allow(User).to receive(:create_user).with("fake_user", "872j932").and_return(true)
    end

    it 'then should redirect to signin for user to log in' do
      post :create, {:user => {:user_name => "fake_user", :password => "872j932"}}
      expect(response).to redirect_to('/signin')
    end
  end

  describe "When an existing user wants to sign up" do
    let!(:user_1) { FactoryGirl.create(:user) }

    it 'should send corresponding request and render signup template' do
      get :signup
      expect(response).to render_template("signup")
    end

    it 'should call model user to create user and model should return false' do
      post :create, {:user => {:user_name => "fake_user", :password => "872j932"}}
      allow(User).to receive(:create_user).with("fake_user", "872j932").and_return(false)
    end

    it 'then should redirect to signup to try one more time' do
      post :create, {:user => {:user_name => "fake_username", :password => "872j932"}}
      allow(User).to receive(:create_user).with("fake_username", "872j932").and_return(false)
      expect(response).to redirect_to('/signup')
    end
  end

end