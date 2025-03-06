class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :configure_premitted_parameters, if: :devise_controller?

  protected

  def configure_premitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :avatar, :name, :website, :bio, :gender, :birthday, :location ])
  end
end
