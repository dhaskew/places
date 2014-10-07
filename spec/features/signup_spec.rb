require 'rails_helper'

feature 'Sign-Up' do
  describe 'with valid information' do
    it 'should create user' do
     @valid_user = build :user
      visit new_user_registration_path    
      within("//form[@id='new_user']") do
        fill_in "Email", with: @valid_user.email
        fill_in "Password", with: @valid_user.password
        fill_in "Password confirmation", with: @valid_user.password 
      end
      expect{ click_button 'Sign up' }.to change(User, :count).by(1)
      expect( current_path ).to eq('/user_setup')
    end
  end
end
