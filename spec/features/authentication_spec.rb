require 'rails_helper'

feature 'Authentication' do
  
  describe 'when you are an existing user' do
    
    describe 'who is not setup or has expired tokens' do
      
      before :each do
        @user = create :user
        login @user
      end
      
      it 'requires the initial setup to be complete' do
        expect( @user.setup? ).to eq(false)
        expect( current_path ).to eq(user_setup_path)
      end

    end
    
    describe 'who is fully setup, active, and current' do
      
      before :each do
        @u2 = create :user, :evernote_connected
        login @u2
      end

      it 'should send the user to their dashboard' do
        expect( @u2.setup? ).to eq(true)
        expect( current_path ).to eq(dashboard_path)
      end

    end

  end
end
