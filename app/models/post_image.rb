class PostImage < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :post_comments, dependent: :destroy


  validates :title, presence: true
  validates :image, presence: true

  def liked_by?(post_image_id)
    likes.where(post_image_id: post_image_id).exists?
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
