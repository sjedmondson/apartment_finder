class User < ActiveRecord::Base

  has_many :listings
  has_one :preference
  validates :username,
    presence: true
  validates :password,
    presence: true
  validates :email,
    presence: true,
    format: {
      with: /\w+@(\w+\.)+\w{2,}/,
      message: "must be a valid email format!"
    }

  after_create do
    preference = Preference.create
    self.preference = preference
    self.save
  end
    
end