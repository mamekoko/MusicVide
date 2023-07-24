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

  if like
    like.destroy
    render json: @post_image
  else
    # エラー処理（例：likeが見つからない場合の処理）
    render json: { error: 'Like not found' }, status: :not_found
  end
  end

  private

  def set_post_image
    @post_image = PostImage.find(params[:post_image_id])
  end

end
