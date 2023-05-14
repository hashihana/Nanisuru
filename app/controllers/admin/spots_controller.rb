class Admin::SpotsController < ApplicationController
  
  
    def new
      @spot = Spot.new
    end
  
   def index
    @genres = Genre.only_active
    if params[:genre_id]
      @genre = @genres.find(params[:genre_id])
      all_spots = @genre.spots
    else
      all_spots = Spot.where_genre_active.includes(:genre)
    end
    @spots = all_spots.page(params[:page]).per(12)
    @all_spots_count = all_spots.count
   end
  
  def search
    @spots = Spot.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
  def create
    @spot = Spot.new(spot_params)
    @spot.save ? (redirect_to admin_spot_path(@spot)) : (render :new)
  end

  def show
    @spot = Spot.where_genre_active.find(params[:id])
    @review = Review.new
    @genres = Genre.only_active
    # @reviews = Reviews.all
  end

  def edit
  end

  def update
    @spot.update(spot_params) ? (redirect_to admin_spot_path(@spot)) : (render :edit)
  end

  private

  def spot_params
    params.require(:spot).permit(:genre_id, :name, :introduction, :spot_image, :address, :prefecture_id)
  end
  
end
