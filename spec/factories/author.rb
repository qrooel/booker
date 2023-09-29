FactoryBot.define do
  factory :author do
    first_name { "Jan-#{SecureRandom.hex(2)}" }
    last_name { "Kowalski-#{SecureRandom.hex(2)}" }
    genre { 'fantasy' }

    factory :author_with_books do
      after(:create) do |author, _evaluator|
        create_list(:book, 2, author: author)
      end
    end
  end
end
