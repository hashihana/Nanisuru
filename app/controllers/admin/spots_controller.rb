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

    @reviews = Review.all
    @all_rating = '総合評価'
    @rating1 = '評価1'
    @rating2 = '評価2'
    @rating3 = '評価3'
    @rating4 = '評価4'
   end
  
  def search
    @spots = Spot.search(params[:keyword]).page(params[:page]).per(12)
    @genres = Genre.only_active
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
    @reviews = Review.all
    # @reviews = Reviews.all
  end

  def edit
    @spot = Spot.where_genre_active.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      flash[:notice] = "投稿の更新に成功しました"
      redirect_to admin_spot_path(@spot)
    else
      render :edit
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:genre_id, :name, :introduction, :spot_image, :address, :prefecture_id)
  end
  
end
