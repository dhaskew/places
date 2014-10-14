class Location < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address
  after_validation :geocode,
    :if => lambda{ |obj| obj.address_changed? }

end
