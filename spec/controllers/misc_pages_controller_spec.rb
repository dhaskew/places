require 'rails_helper'

describe MiscPagesController do

  describe "For logged-in users" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create :user
      sign_in @user
    end
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
