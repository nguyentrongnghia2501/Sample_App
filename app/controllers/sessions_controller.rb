# frozen_string_literal: true

# Service to download ftp files from the server
class SessionsController < ApplicationController
  def new; end

  def create # rubocop:disable Metrics/MethodLength
    user = User.find_by(email: params[:session][:email].downcase)
  #  binding.pry
    if user && user.valid_password?(params[:session][:password])
      # Log the user in and redirect to the user's show page.
          if user.activated?
            forwarding_url = session[:forwarding_url]
            reset_session
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_to forwarding_url || user
         else
            message = "Account not activated."
            message += "Check your email for the activation link."
            flash[:warning] = message
            redirect_to root_url
        end

    else
      # Create an error message.
      flash.now[:danger] = 'sai tài khoản hoặc mật khẩu' # Not quite right!
    render 'new'
    end
  end

    def destroy
      log_out if logged_in?
      redirect_to root_url
     end

end
