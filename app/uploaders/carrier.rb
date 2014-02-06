class MyUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_fit => [48, 64]

  version :thumb do
    process :resize_to_fill => [48, 64]
  end

  def store_dir
    'public/photos'
  end
end