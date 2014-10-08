# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  evernote_token         :string(255)
#  evernote_token_dttm    :datetime
#

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

  it "has a message count of unread messages in his/her inbox" do
    expect( @user.inbox_unread_count ).to eq(0) 
    create :message, read: false, user: @user
    expect( @user.inbox_unread_count ).to eq(1)
  end

end
