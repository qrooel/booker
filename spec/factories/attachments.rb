# frozen_string_literal: true

# == Schema Information
#
# Table name: attachments
#
#  id         :bigint           not null, primary key
#  file       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :attachment do
    file { Rack::Test::UploadedFile.new('spec/fixtures/files/test.txt', 'text/plain') }
  end
end
