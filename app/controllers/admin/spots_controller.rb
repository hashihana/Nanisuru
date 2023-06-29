class Admin::SpotsController < ApplicationController

    def new
      @spot = Spot.new
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
    end
    @spots = spots.page(params[:page]).per(6)
    @all_spots_count = spots.length
   end

  def create
    @spot = Spot.new(spot_params)
    @spot.save ? (redirect_to admin_spot_path(@spot)) : (render :new)
  end

  def show
    @spot = Spot.where_genre_active.find(params[:id])
    @review = Review.new
    @genres = Genre.only_active
    @reviews = Review.where(spot:@spot).page(params[:page]).per(3).reverse_order
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

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to admin_spots_path
  end

  private

  def spot_params
    params.require(:spot).permit(:genre_id, :name, :introduction, :spot_image, :address, :prefecture_id)
  end

end
