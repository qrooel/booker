# frozen_string_literal: true

module TestHelper
  def create_token(user)
    Authentication::Tokens::Creator.new.call(user)
  end

  def parse_token_to_json(token)
    JSON.parse(Base64.urlsafe_decode64(token)).fetch('access-token')
  end

  def create_attachment(user)
    compressor_klass = Attachments::Compressor.new.call(sample_upload_file, compressor: :zip)
    Attachments::Creator.new.call(user, compressor_klass.archive)
  end

  def sample_upload_file
    fixture_file_upload 'spec/fixtures/files/test.txt', 'text/plain'
  end
end
