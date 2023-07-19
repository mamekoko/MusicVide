class Public::LikesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :post_image_params, only: [:create, :destroy]

  def create
    Like.create(user_id: current_user.id, post_image_id: @post_image.id)
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_image_id: @post_image.id)
    like.destroy
  end

  private

  def post_imaage_params
    @post_image = PostImage.find(params[:post_image_id])
  end

end
