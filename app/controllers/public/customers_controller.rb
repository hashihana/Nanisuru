class Public::CustomersController < ApplicationController
  
  before_action :is_guest?
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @customer = Customer.find(params[:id])
    @reviews = Review.where(customer_id: @customer.id).page(params[:page]).per(10).reverse_order
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
    @customer = current_customer
  end
  
  def withdraw
      @customer = Customer.find(current_customer.id)
      @customer.update(is_active: false)
      reset_session
      flash[:notice] = "退会完了しました。またの機会がありましたら、ご利用よろしくお願い申し上げます。"
      redirect_to root_path
  end


  private
  
  def is_matching_login_user
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to spots_path
    end
  end

  def set_current_customer
    @customer = current_customer
  end

  def is_guest?
    if current_customer == Customer.guest
      redirect_to root_path
    end
  end

  def customer_params
    params.require(:customer).permit(:nickname, :email, :profile_image)
  end
end