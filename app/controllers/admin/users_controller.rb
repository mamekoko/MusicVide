class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path(@user), notice: 'User was successfully updated.'
    else
      render :show
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :admin)
  end

end
