class Public::HomesController < ApplicationController

  def top
    @genres = Genre.only_active.includes(:spots)
    @random = Spot.find(Spot.pluck(:id).shuffle[0..3])
  end

end
