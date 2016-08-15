class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :listing

  validates :user_id,
    presence: true

  validates :content,
    presence: true,
    length: {
      minimum: 20,
      maximum: 200
    }

  validates :rating,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 5
    }

end