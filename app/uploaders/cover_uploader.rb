class CoverUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "public/uploads/cover/#{model.id}"
  end

  def filename
    "#{secure_token(40)}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token(length = 16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.hex(length))
  end

end
