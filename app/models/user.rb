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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  has_many :messages
  has_many :enotes
  #validates :email, presence: true
  #validates :password, presence: true

  def setup?
    evernote_valid?
  end

  def inbox_unread_count 
    self.messages.where(read: false).count    
  end

  private

  def evernote_valid?
    return false if self.evernote_token == nil
    return false if self.evernote_token_dttm == nil
    return false if self.evernote_token_dttm + 364.days < Time.now
    return true    
  end
    
end
