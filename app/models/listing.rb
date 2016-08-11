class Listing < ActiveRecord::Base
  
  validates :price,
    presence: true
  validates :area,
    presence: true
  validates :street_address,
    presence: true
    
  # after_validation do
  #   full_street_address = street_address + ", Vancouver"
  #   result = Geocoder.search(street_address)
  #   self.longitude = result[0].longitude
  #   self.latitude result[0].latitude
  # end


end