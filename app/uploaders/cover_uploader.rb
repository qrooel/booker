class CoverUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "db/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
