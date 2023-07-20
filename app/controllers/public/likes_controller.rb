class Public::LikesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post_image, only: [:create, :destroy]

  def create
    @post_image.likes.create(user_id: current_user.id)

     respond_to do |format|
      format.js { render json: @post_image }
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_image_id: @post_image.id)
    like&.destroy

    respond_to do |format|
      format.js { render json: @post_image }
    end
  end

  private

  def set_post_image
    @post_image = PostImage.find(params[:post_image_id])
  end

end
