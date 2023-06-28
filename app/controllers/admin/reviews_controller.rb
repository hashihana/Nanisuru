class Admin::ReviewsController < ApplicationController

  def show
     @review = Review.find(params[:id])
  end

  def index
      @customer = Customer.find(params[:customer_id])
      @reviews = Review.where(customer_id: @customer.id).page(params[:page]).per(10).reverse_order
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
        redirect_to admin_customer_reviews_path(@customer)
      else
        redirect_to admin_spot_path(@spot)
      end
  end


  private

    def review_params
      params.require(:review).permit(:comment, :all_rating, :rating1, :rating2, :rating3, :rating4).merge(
         customer_id: current_customer.id, spot_id: params[:spot_id]
    )
    end
end

