class Public::UsersController < ApplicationController

  before_action :set_user, only: [:likes]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def likes
    @user = User.find(params[:id])
    @users = @user.post_images.page(params[:page])
    @liked_post_images = @user.liked_post_images
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
