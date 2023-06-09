class ApplicationController < ActionController::Base
  
  before_action :authenticate_customer_unless_admin!,except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  def after_sign_in_path_for(resource)
    if customer_signed_in?
        root_path
    else
      admin_spots_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      admin_session_path
    else root_path
    end
  end
    
  def authenticate_customer_unless_admin!
    unless current_admin
      authenticate_customer!
    end
  end
  
   protected

   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
   end
end

  
  
