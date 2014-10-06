require 'rails_helper'

feature 'Authentication' do
  describe 'when you are an existing user' do
    before :each do
      @user = create :user
      login @user
    end

    it 'requires the initial setup to be complete'
  
  end
end
