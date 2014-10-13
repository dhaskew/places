class Visit < ActiveRecord::Base
  belongs_to :enote
  belongs_to :location
  geocoded_by :address
  after_validation :geocode,
    :if => lambda{ |obj| obj.address_changed? }
end
