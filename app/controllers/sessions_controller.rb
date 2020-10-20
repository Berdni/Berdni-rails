class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    remember(@user)
    redirect_to root_path
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
