class MiscPagesController < ApplicationController
 skip_before_filter :authenticate_user!, only: :landing_page
 layout false, only: :landing_page

  def user_setup
  end

  def landing_page
  end

  def dashboard
  end

end
