class Admin::ReviewsController < ApplicationController

    # before_action :authenticate_user!

  def show
     @review = Review.find(params[:id])
  end

  def index
      @customer = Customer.find(params[:customer_id])
      @reviews = Review.where(customer_id: @customer.id).page(params[:page])
      #@spot = Spot.find(params[:spot_id])
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    @comment = Review.find_by(params[:id])
    @comment.destroy
    redirect_to admin_customer_reviews_path(@customer)
  end

  private

    def review_params
      params.require(:review).permit(:comment, :all_rating, :rating1, :rating2, :rating3, :rating4).merge(
         customer_id: current_customer.id, spot_id: params[:spot_id]
    )
    end
end

