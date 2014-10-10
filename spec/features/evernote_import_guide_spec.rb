require 'rails_helper'

feature 'Evernote data import' do
  it 'should give the user a chance to select a notebook' #do
   # @user = create :user, :evernote_connected
   # login @user
   # visit evernote_setup_path
   # expect( page ).to have_css('#radio_folders')
   # expect( page ).to have_css('#button_import')
   # click_button "Import Data"
   # expect( current_page ).to eq(dashboard_path)
  #end
  it 'should give the user a chance to select specific tags'
  describe 'from a specific notebook' do
    it 'should display a list of notebooks for selection'
  end
  describe 'using specific tags' do
    it 'should display a list of tags for seleciton'
  end
end 
