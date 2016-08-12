class Preference < ActiveRecord::Base
  belongs_to :user

  validates :user_id,
    presence: true,
    uniqueness: true
  validates :max_price,
    numericality: {
      greater_than_or_equal_to: 0
    }
  validates :min_area,
    numericality: {
      greater_than_or_equal_to: 0
    }
  validates :min_bedrooms,
    numericality: {
      greater_than_or_equal_to: 0
    }
  validates :min_bathrooms,
    numericality: {
      greater_than_or_equal_to: 0
    }
end