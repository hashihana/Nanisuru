class Admin::SpotsController < ApplicationController
  
  
    def new
      @spot = Spot.new
    end
  
   def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = @genres.find(params[:genre_id])
      all_spots = @genre.spots
    else
      all_spots = Spot.all.includes(:genre)
    end
    @spots = all_spots.page(params[:page]).per(12)
    @all_spots_count = all_spots.count
  end
  
  def search
    @spots = Spot.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
  
end
