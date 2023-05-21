class Admin::ReviewsController < ApplicationController
  
    # before_action :authenticate_user!

  # def create
  #   spot = Spot.find(params[:spot_id])
  #   @review = spot.reviews.build(review_params)
  #   @review.customer_id = current_customer.id
  #   if @review.save
  #     flash[:success] = "コメントしました"
  #     redirect_back(fallback_location: root_path)
  #   else
  #     flash[:success] = "コメントできませんでした"
  #     redirect_back(fallback_location: root_path)
  #   end
  # end
  
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
    @comment = current_customer.reviews.new(review_params)
    @comment.spot_id = spot.id
    @comment.save
  end

  def destroy
    @comment = Review.find_by(id: params[:id], spot_id: params[:spot_id])
    @comment.destroy
  end

  private

    def review_params
      params.require(:review).permit(:comment)
    end
end

