FactoryBot.define do
  factory :book do
    title { "Ixion-#{SecureRandom.hex(2)}" }
    data { { isbn: "aaa-bbb-ccc-111", pages: 333 } }
    cover { Rack::Test::UploadedFile.new('spec/fixtures/files/ixion.jpg', 'image/jpeg') }

    factory :book_with_author do
      before(:create) do |book, _evaluator|
        create(:author, books: [book])
      end
    end
  end
end
