class User < ActiveRecord::Base

  has_one :account
  validates :username,
    presence: true
    
end