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

  # def get_current_bar
  #   # @nickname = current_user.nickname
  #   @email = current_user.nickname
  #   @image = current_user.image
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:update_account, keys: [:nickname, :avatar, :field, :birth])

    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar, :field, :birth])

  end

end
