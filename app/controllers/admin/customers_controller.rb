class Admin::CustomersController < ApplicationController
    
# before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
      
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
        flash[:success] = "Customer was successfully updated"
        redirect_to admin_customer_path(@customer)
    else
        render "edit"
    end
 end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :email, :is_deleted)
  end
  
end
    
