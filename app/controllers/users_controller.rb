class UsersController < ApplicationController
  def post_signin
    ret = User.validate_user(user_params[:user_name], user_params[:password])
    if ret.empty?
      flash[:notice] = "Sign in success."
      session[:user_name] = user_params[:user_name]
      redirect_to '/'
    else
      flash[:notice] = ret
      redirect_to signin_users_path
    end
  end

  def create
    success = User.create_user(user_params[:user_name], user_params[:password])
    if success
      flash[:notice] = "Sign up success."
      redirect_to signin_users_path
    else
      flash[:notice] = "Username exists."
      redirect_to signup_users_path
    end
  end

  def logout
    session.delete(:user_name)
    redirect_to '/'
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end