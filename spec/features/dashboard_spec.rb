require 'rails_helper'

feature 'Dashboard' do
  describe 'when a user does not have messages' do
    
    it 'should should a default of 0 inbox messages' do
      @user = create :user, :evernote_connected
      login @user
      expect( @user.setup? ).to eq true
      expect( current_path ).to eq dashboard_path
      expect( page ).to have_css('#inbox_count', text: 'Inbox 0') 
    end

  end
  
  describe 'when a user has messages' do
    it 'should show an accurate count of inbox messages' do
      @user = create :user, :evernote_connected
      @message = create :message, user: @user
      login @user
      expect( current_path ).to eq dashboard_path
      expect( page ).to have_css('#inbox_count', text: 'Inbox 1')
    end
  end

end
