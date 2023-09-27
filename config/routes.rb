Rails.application.routes.draw do
  # root "articles#index"

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Books::API => '/'
  mount Authors::API => '/'
end
