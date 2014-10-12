class Visit < ActiveRecord::Base
  belongs_to :enote
  geocoded_by :address
  after_validation :geocode,
    :if => lambda{ |obj| obj.address_changed? }
end
