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

  describe 'When an existing user wants to sign in' do
    let!(:signin_user) {FactoryGirl.create(:user, user_name: 'signin_user', password: User.encode_password('user_pw'))}

    it 'should sign in successfully' do
      post :post_signin, {:user => {:user_name => 'signin_user', :password => 'user_pw'}}
      expect(response).to redirect_to '/'
    end

    it 'should fail to sign in' do
      post :post_signin, {:user => {:user_name => 'signin_user', :password => 'wrong_pw'}}
      expect(response).to redirect_to signin_users_path
      post :post_signin, {:user => {:user_name => 'nonexistent_user', :password => ''}}
      expect(response).to redirect_to signin_users_path
    end
  end

  describe 'When an existing user wants to log out' do
    let!(:signin_user) {FactoryGirl.create(:user, user_name: 'signin_user', password: User.encode_password('user_pw'))}

    it 'should log out successfully' do
      post :post_signin, {:user => {:user_name => 'signin_user', :password => 'user_pw'}}
      expect(session).to include :user_name

      post :logout
      expect(session).not_to include :user_name
      expect(response).to redirect_to '/'
    end
  end

end