class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def evernote
    @user = current_user 
    #puts session[:authtoken]
    session[:en_token] = params["oauth_token"]
    session[:en_cred_token] = request.env["omniauth.auth"]["credentials"]["token"]
    session[:en_verifier] = params["oauth_verifier"]
 
    set_flash_message(:notice, :success, :kind => "Evernote") if is_navigational_format?
    session["devise.evernote_data"] = request.env["omniauth.auth"]
    redirect_to dashboard_path 
  end
  
end


