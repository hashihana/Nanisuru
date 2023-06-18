class Public::CustomersController < ApplicationController

  # before_action :authenticate_customer!
  # before_action :set_current_customer

  def show
    @customer = Customer.find(params[:id])
    @reviews = Review.where(customer_id: @customer.id).page(params[:page]).per(10).reverse_order
    # @spot = Spot.find(params[:id])
    @review = Review.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def confirm_withdraw
  end

  private

  def set_current_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(:nickname, :email)
  end
end