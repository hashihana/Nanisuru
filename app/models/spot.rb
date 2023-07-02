class Spot < ApplicationRecord

  has_one_attached :spot_image
  has_many :reviews, dependent: :destroy
  belongs_to :genre
  def self.search(keyword)
    where(["name like? OR address like? OR introduction like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  belongs_to :prefecture
  
  scope :where_genre_active, -> { joins(:genre).where(genres: { is_active: true }) }
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  validates :name, presence: true
  validates :address, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :prefecture_id, presence: true

  # attr_accessor :average
  def average_score
    self.reviews.sum(:all_rating) / self.reviews.length
  end

  def get_spot_image(width, height)
  unless spot_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    spot_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    spot_image.variant(resize_to_limit: [width, height]).processed
  end

end
