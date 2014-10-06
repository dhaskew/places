require 'rails_helper'

RSpec.describe User, :type => :model do
  before :each do
    @user = create :user
  end
  
  it "is setup when evernote is connected" do
    expect( @user.setup? ).to eq false
    @user.evernote_token = "made up value"
    @user.evernote_token_dttm = Time.now
    expect{ @user.save! }.not_to raise_exception
    expect( @user.persisted? ).to eq true
    expect( @user.setup? ).to eq true
  end

  it "is not setup when the evernote token has expired" do
    expect( @user.setup? ).to eq false
    @user.evernote_token = "made up value"
    @user.evernote_token = Time.now - (365*2)
    expect{ @user.save! }.not_to raise_exception
    expect( @user.setup? ).to eq false 
  end

end
