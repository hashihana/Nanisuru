class Spot < ApplicationRecord
  
  has_many :reviews, dependent: :destroy
  belongs_to :genre
  def self.search(keyword)
    where(["name like? OR address like? OR introduction like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
  
  scope :where_genre_active, -> { joins(:genre).where(genres: { is_active: true }) }
  
  has_one_attached :spot_image
  belongs_to :prefecture
  
  def get_spot_image(width, height)
  unless spot_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    spot_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  spot_image.variant(resize_to_limit: [width, height]).processed
  end

end
