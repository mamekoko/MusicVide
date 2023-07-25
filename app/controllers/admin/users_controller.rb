class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def toggle_suspension
    @user = User.find(params[:id])
    @user.toggle(:suspended)
    @user.save
    redirect_to admin_user_path(@user), notice: 'User suspension status has been updated.'
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user.admin?
  end

end
