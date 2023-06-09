class Genre < ApplicationRecord

  has_many :spots
  scope :only_active, -> { where(is_active: true) }
  
  validates :name, presence: true

end
