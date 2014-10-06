require 'rails_helper'

feature 'Sign-Up' do
    before :each do
      visit new_user_registration_path    
    end

    it 'requires some intial setup'
      #expect( @user.setup? ).to eq false
      #expect( @user.setup? ).to eq true

end
