class Public::PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
      if @post_image.save
        redirect_to post_images_path, notice: '投稿が作成されました。'
      else
        render :new
      end
  end

  def index
    if user_signed_in?
      @post_images = PostImage.where(is_public: true).order(created_at: :desc).page(params[:page])
    else
      @post_images = PostImage.none
    end
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_images = PostImage.all
    @post_comment = PostComment.new
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
      if @post_image.update(post_image_params)
        redirect_to post_images_path
      else
        render :edit
      end
  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to '/post_images'
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :caption, :is_public)
  end

end
