class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :password, presence: true

  def setup?
    evernote_valid?
  end

  private

  def evernote_valid?
    return false if self.evernote_token == nil
    return false if self.evernote_token_dttm == nil
    return false if self.evernote_token_dttm + 364 < Time.now
    return true    
  end
    
end
