class Enote < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :guid, scope: :user_id
  has_many :visits
end
