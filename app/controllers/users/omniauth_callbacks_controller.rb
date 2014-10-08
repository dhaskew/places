class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def evernote
    @user = current_user 
    #puts session[:authtoken]
    #session[:en_token] = params["oauth_token"]
    #session[:en_cred_token] = request.env["omniauth.auth"]["credentials"]["token"]
    #session[:en_verifier] = params["oauth_verifier"]
    @user.evernote_token = request.env["omniauth.auth"]["credentials"]["token"]
    @user.evernote_token_dttm = Time.now
    set_flash_message(:notice, :success, :kind => "Evernote") if is_navigational_format?
    @user.save!
    #session["devise.evernote_data"] = request.env["omniauth.auth"]
    redirect_to dashboard_path 
  end
  
end


