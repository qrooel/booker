# frozen_string_literal: true

module TestHelper
  def sample_upload_file
    fixture_file_upload 'spec/fixtures/files/ixion.jpg', 'text/plain'
  end
end
