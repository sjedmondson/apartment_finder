class Listing < ActiveRecord::Base

  validates :price,
    presence: true
  validates :area,
    presence: true
  validates :street_address,
    presence: true
  validates :latitude,
    presence: true
  validates :longitude,
    presence: true

  before_validation do
    full_street_address = street_address + ", Vancouver, B.C."
    result = Geocoder.search(full_street_address)[0]
    if result && result.state == "British Columbia"
      self.longitude = result.longitude
      self.latitude = result.latitude
    end
  end

end