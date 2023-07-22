class Public::HomesController < ApplicationController

  def top
    @post_images = PostImage.where(is_public: true).limit(5)
  end

end
