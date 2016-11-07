require 'securerandom'
class SessionsController < ApplicationController
  def new
  end

  def create

    if auth_hash = request.env["omniauth.auth"]
      user = User.find_or_create_by_omniauth(auth_hash)
      # oauth_email = request.env["omniauth.auth"][:info][:email]
      # if user = User.find_by(:email => oauth_email)
      #   session[:user_id] = user.id
      #   redirect_to root_path
      # else
      #   user = User.create(email: oauth_email, password: SecureRandom.hex)
      #   if user.save
      #     session[:user_id] = user.id
      #     redirect_to root_path
      #   else
      #     raise user.errors.full_messages.inspect
      #   end
      # end
      session[:user_id] = user.id
      redirect_to root_path
    else
      user = User.find_or_create_by(:email => params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id

        redirect_to root_path
      else
        render 'sessions/new'
      end
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

end
