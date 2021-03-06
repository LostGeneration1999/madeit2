class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_filter :get_current_bar
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource)
    '/users/sign_in'
  end

    def after_sign_in_path_for(resource)
    '/products' # サインアウト後のリダイレクト先URL
    end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password,:password_confirmation, :nickname, :avatar,:field, :birth,:current_password,:tag_list, {:tag_list => []})
    end
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password,:password_confirmation, :nickname, :avatar, :birth, :tag_list, {:tag_list => []})
    end
  end
end

