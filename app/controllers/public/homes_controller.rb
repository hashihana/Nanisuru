class Public::HomesController < ApplicationController
  
  def top
    @genres = Genre.only_active.includes(:spots)
    @random = Spot.order("RANDOM()").limit(4)
  end
  
  def guest_sign_in
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
    customer.password = SecureRandom.urlsafe_base64
  end
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
