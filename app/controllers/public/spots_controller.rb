class Public::SpotsController < ApplicationController

  def show
    @spot = Spot.where_genre_active.find(params[:id])
    @review = Review.new
    @reviews = Review.all
    @genres = Genre.only_active
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
    params.require(:spot).permit(:genre_id, :name, :introduction, :spot_image, :address, :prefecture_id)
  end