FactoryBot.define do
  factory :author do
    first_name { 'Jan' }
    last_name { 'Kowalski' }
    genre { 'fantasy' }

    factory :author_with_books do
      after(:create) do |author, _evaluator|
        create_list(:book, 2, author: author)
      end
    end
  end
end
