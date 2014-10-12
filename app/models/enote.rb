class Enote < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :guid
end
