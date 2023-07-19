class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_post_images, through: :likes, source: :post_image

  has_many :post_comments, dependent: :destroy

  has_one_attached :profile_image

  def liked_by?(post_image_id)
    likes.where(post_image_id: post_image_id).exists?
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
