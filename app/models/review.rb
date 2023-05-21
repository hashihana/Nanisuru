class Review < ApplicationRecord
  
    belongs_to :customer
    belongs_to :spot
    
    scope :reviewed_today, -> { where(created_at: Time.current.at_beginning_of_day..Time.current.at_end_of_day) }

end
