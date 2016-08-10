class Listing < ActiveRecord::Base
  validates :price,
    presence: true
  validates :area,
    presence: true
  validates :url,
    presence: true
end