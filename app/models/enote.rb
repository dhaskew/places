class Enote < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :guid
  has_many :visits
end
