class PostImage < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  has_many :likes, dependent: :destroy

  has_many :post_comments, dependent: :destroy


  validates :title, presence: true
  validates :image, presence: true

  def liked_by?(user, post_image)
    likes.where(user_id: user.id).exists?
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post_image = PostImage.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post_image = PostImage.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post_image = PostImage.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post_image = PostImage.where("title LIKE?","%#{word}%")
    else
      @post_image = PostImage.all
    end
  end

end
