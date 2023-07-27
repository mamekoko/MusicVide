class Public::LikesController < ApplicationController

  def create
    post_image = PostImage.find(params[:post_image_id])
    @likes = current_user.likes.new(post_image_id: post_image.id)
    @likes.save
    #render 'replace_btn'
  end

  def destroy
    post_image = PostImage.find(params[:post_image_id])
    @likes = current_user.likes.find_by(post_image_id: post_image.id)
    @likes.destroy
    #render 'replace_btn'
  end

end
