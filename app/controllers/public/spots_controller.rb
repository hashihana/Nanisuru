class Public::SpotsController < ApplicationController

  def show
    @spot = Spot.where_genre_active.find(params[:id])
    @review = Review.new
    @reviews = Review.all
    @genres = Genre.only_active
  end

  def index
    @genres = Genre.only_active
    if params[:latest]
      all_spots = Spot.latest
    elsif params[:old]
      all_spots = Spot.old
     elsif params[:star_count]
      all_spots = Spot.all.each do |spot|
      spot.average = spot.average_score
    end
      all_spots = all_spots.sort_by { |spot| -spot.average }
     
    elsif params[:genre_id]
      @genre = @genres.find(params[:genre_id])
      all_spots = @genre.spots
    else
      all_spots = Spot.where_genre_active.includes(:genre)
    end
    if params[:star_count]
      @spots = Kaminari.paginate_array(all_spots).page(params[:page]).per(12)
    else
      @spots = all_spots.page(params[:page]).per(12)
    end
      @all_spots_count = all_spots.count
  end
end

  def search
    spots = params[:keyword].present? ? Spot.search(params[:keyword]) : Spot.all
    spots = spots.where(genre_id: params[:genre_id]) if params[:genre_id].present?
    spots = spots.where(prefecture_id: params[:prefecture_id]) if params[:prefecture_id].present?
    @spots = spots.page(params[:page]).per(12)

    @genre = Genre.find_by(id: params[:genre_id])
    @genres = Genre.only_active
    @prefectures = Prefecture.all
    @keyword = params[:keyword]
    render "index"

    # @spots = Spot.search(params[:keyword])
    # @keyword = params[:keyword]
    # render "index"
  end

   private

  def spot_params
    params.require(:spot).permit(:genre_id, :name, :introduction, :spot_image, :address, :prefecture_id )
  end