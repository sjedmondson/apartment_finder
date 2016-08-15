class Listing < ActiveRecord::Base

  belongs_to :user
  has_many :comments
  has_many :images

  validates :street_address,
    presence: true

  validates :price,
    numericality: {
      greater_than: 0,
    }

  validates :area,
    numericality: {
      greater_than: 0,
    }

  validates :bedrooms,
    presence: true,
    numericality: {
      greater_than: 0,
    }

  validates :bathrooms,
    presence: true,
    numericality: {
      greater_than: 0
    }

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