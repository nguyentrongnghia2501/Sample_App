# frozen_string_literal: true

module SessionsHelper
  # Logs in the given user. Đăng nhập vào người dùng nhất định.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).Trả về người dùng đã đăng nhập hiện tại (nếu có)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Returns true if the user is logged in, false otherwise.
  # Trả về true nếu người dùng đã đăng nhập, trả về false nếu ngược lại.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user
  # Đăng xuất người dùng hiện tại
  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

  # Remembers a user in a persistent session.
  # Nhớ người dùng trong một phiên liên tục.
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  # Returns the user corresponding to the remember token cookie.
  # Trả về người dùng tương ứng với cookie mã nhớ.

  def current_user
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
    # @current_user ||= user if FILL_IN #error
    elsif (user_id = cookies.encrypted[:user_id]) # Trả về người dùng đã đăng nhập hiện tại (nếu có).

      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Trả về true nếu người dùng đã cho là người dùng hiện tại.
  def current_user?(user)
    user && user == current_user
  end

  # Tạo ra một phiên liên tục.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
