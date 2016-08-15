class User < ActiveRecord::Base

  has_many :listings
  has_many :comments
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
  validates :first_name,
    presence: true
  validates :last_name,
    presence: true
  validates :phone,
    presence: true,
    format: {
      with: /\d{3}-\d{3}-\d{4}/,
      message: "must be a valid phone format!"
    }

  after_create do
    preference = Preference.create
    self.preference = preference
    self.save
  end
    
end