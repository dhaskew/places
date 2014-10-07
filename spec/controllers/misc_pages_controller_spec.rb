require 'rails_helper'

describe MiscPagesController do

  describe "For logged-in users" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create :user
      sign_in @user
    end
    describe "GET landing_page" do
      it "returns http success" do
        get :landing_page
        expect(response).to have_http_status(:success)
      end
    end
    describe "GET dashboard" do
      it "returns http success" do
        get :dashboard
        expect(response).to have_http_status(:success)
      end
    end
  
  end
end
