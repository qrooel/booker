# frozen_string_literal: true

module TestHelper
  def sample_upload_file
    fixture_file_upload 'spec/fixtures/files/test.txt', 'text/plain'
  end
end
