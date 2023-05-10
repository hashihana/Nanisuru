class Admin::ReviewsController < ApplicationController
  
    before_action :authenticate_user!

  def create
    spot = Spot.find(params[:spot_id])
    @review = spot.reviews.build(review_params)
    @review.customer_id = current_customer.id
    if @review.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def review_params
      params.require(:review).permit(:content)
    end
end

