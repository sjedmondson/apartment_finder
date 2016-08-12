class User < ActiveRecord::Base

  has_many :listings
  has_one :preference
  validates :username,
    presence: true

  after_create do
    preference = Preference.create
    self.preference = preference
    self.save
  end
    
end