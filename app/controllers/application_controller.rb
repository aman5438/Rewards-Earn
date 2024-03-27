class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :streaming_count

  def devise_current_user
    @devise_current_user ||= warden.authenticate(scope: :user)
  end

  def current_user
    if session[:user_id].blank?
      devise_current_user
    else
      User.find(session[:user_id])
    end   
  end


  protected
    def streaming_count
      @total_streams = Stream.sum(:count)
    end

    def configure_permitted_parameters
      permitted_keys = [:first_name, :last_name, :birth_year, :country_code, :email, :password, :password_confirmation]

      if (params.dig("user","invite_username").present? rescue false)
        user = User.find_by(username: params["user"]["invite_username"])
        if user&.rewards_action
          devise_parameter_sanitizer.permit(:sign_up, keys: permitted_keys)
        else
          flash[:error] = "Invaliad user"
          redirect_to dashboard_home_index_path
        end
      else
        devise_parameter_sanitizer.permit(:sign_up, keys: permitted_keys)
      end
    end

    def user_signed_in?
      if session["user_id"].present?
        return true
      end
    end
end
