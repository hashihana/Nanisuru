class Public::SpotsController < ApplicationController

  def show
    @spot = Spot.where_genre_active.find(params[:id])
    @review = Review.new
     @reviews = Review.where(spot:@spot).page(params[:page]).per(3).reverse_order
    @genres = Genre.only_active
  end

  def index
    @genres = Genre.only_active
    @genre = Genre.find_by(id: params[:genre_id])
    spots = params[:keyword].present? ? Spot.search(params[:keyword]) : Spot.all
    spots = spots.where(genre_id: params[:genre_id]) if params[:genre_id].present?
    spots = spots.where(prefecture_id: params[:prefecture_id]) if params[:prefecture_id].present?
    if params[:latest]
      spots = spots.latest
    elsif params[:old]
      spots = spots.old
    elsif params[:star_count]
      spots = spots.left_joins(:reviews).group(:id).order("AVG(reviews.all_rating) desc");
    end

    @all_spots_count = spots.length
    @spots = spots.page(params[:page]).per(6)
  end

   private

  def spot_params
    params.require(:spot).permit(:genre_id, :name, :introduction, :spot_image, :address, :prefecture_id )
  end
end