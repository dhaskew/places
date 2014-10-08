class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :layout_by_resource

  def after_sign_in_path_for(user)
    if user.setup?
      dashboard_path
    else
      user_setup_path
    end
  end

  protected

  def layout_by_resource
    if devise_controller?
      "landing" 
    else
      "application"
    end
  end

end
