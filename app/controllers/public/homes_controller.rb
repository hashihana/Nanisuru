class Public::HomesController < ApplicationController
  
  def top
    @genres = Genre.only_active.includes(:spots)
    @random = Spot.order("RANDOM()").limit(4)
  end
  
   
end
