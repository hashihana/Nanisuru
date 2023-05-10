class Spot < ApplicationRecord
  
  
  def self.search(keyword)
    where(["name like? OR address like?", "%#{keyword}%", "%#{keyword}%"])
  end
  
end
