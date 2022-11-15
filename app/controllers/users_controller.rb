# frozen_string_literal: true

# Service to download ftp files from the server
class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy
  def new
    @user = User.new
  end

  def show
          @user = User.find(params[:id])
          #redirect_to root_url and return unless FILL_IN    ?????????
         @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # reset_session
      # log_in @user
      # flash[:success] = "Welcome to the Sample App!"
      # redirect_to @user
      #gui gmail

          @user.send_activation_email
          UserMailer.account_activation(@user).deliver_now
          flash[:info] = "Please check your email to activate your account."
          redirect_to root_url
          #xxxxxxxx
      # @user.send_activation_email
      # flash[:info] = "Please check your email to activate your account."
      # redirect_to root_url
    # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    # Handle a successful update.
    else
      render 'edit'
    end
  end



  def index
    # @users = User.all.paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # following
  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters# Trước bộ lọc
  # Confirms a logged-in user.# Xác nhận người dùng đã đăng nhập.
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
