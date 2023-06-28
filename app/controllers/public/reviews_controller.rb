class Public::ReviewsController < ApplicationController

  def show
     @spot = Spot.find(params[:id])
     @review = Review.new
  end

  def index
    if params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @reviews = @customer.reviews.page(params[:page])
    elsif params[:created_at] == "today"
      @reviews = Review.reviewed_today.includes(:customer).page(params[:page])
    else
      @reviews = Review.includes(:customer).page(params[:page])
    end
  end

  def create
    spot = Spot.find(params[:spot_id])
    comment = Review.new(review_params)
    comment.save
    redirect_to spot_path(spot)
  end

  def destroy
    unless params[:customer_id].nil?
      @customer = Customer.find(params[:customer_id])
    else
      @spot = Spot.find(params[:spot_id])
    end
    @comment = Review.find(params[:id])
    @comment.destroy
    if @spot.nil?
      redirect_to customer_path(@customer)
    else
      redirect_to spot_path(@spot)
    end
  end

  private

    def review_params
      params.require(:review).permit(:comment, :all_rating, :rating1, :rating2, :rating3, :rating4).merge(
         customer_id: current_customer.id, spot_id: params[:spot_id]
    )
    end
end
