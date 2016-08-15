require 'carrierwave/orm/activerecord'

class ImageUploader < CarrierWave::Uploader::Base
  storage :file
  def store_dir
    '../../public/uploads'
  end
end

class Image < ActiveRecord::Base
  belongs_to :listing
  mount_uploader :image, ImageUploader

end