# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

describe Books::API, type: :request do

  book_properties = {
    id: { type: :integer },
    title: { type: :string },
    cover_link: { type: :string },
    data: { type: :json },
    author: {
      type: :object,
      properties: {
        id: { type: :integer },
        first_name: { type: :string },
        last_name: { type: :string },
        genre: { type: :string }
      }
    }
  }

  path '/api/books' do
    get "List authors" do #
      tags 'Books'
      produces 'application/json'

      let(:book) { create(:book_with_author) }

      before do
        book
      end

      response '200', 'ok' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: book_properties, required: %w[id title author]
               }

        run_test!
      end

    end
  end

  path '/api/books/{id}' do
    get "Show book details" do
      let(:book) { create(:book_with_author) }

      before do
        book
      end

      tags 'Books'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'ok' do
        schema type: :object,
               properties: book_properties, required: %w[id title author]

        let(:id) { book.id }

        run_test!
      end

      response '404', 'Record not found' do
        let(:id) { 999 }

        run_test!
      end

    end
  end

  path '/api/books' do
    post "Create book" do
      let(:author) { create(:author) }

      tags 'Books'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          author_id: { type: :string }
        },
        required: ['title']
      }

      response '201', 'Created' do
        schema type: :object,
               properties: book_properties, required: %w[id title author]

        let(:book) { { title: "Andrzej", author_id: author.id } }

        run_test!
      end

      response '403', 'Validation errors' do
        schema type: :object,
               properties: {
                 error: { type: :object }
               },
               required: %w[error]

        let(:book) { { title: nil, author_id: nil } }

        run_test!
      end

      response '500', 'Params (author_id) are missing' do
        let(:book) { { title: nil } }

        run_test!
      end

    end
  end

  path '/api/books/{id}' do
    put "Update book" do
      tags 'Books'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string }
        },
        required: ['title']
      }

      response '200', 'Updated' do
        let(:example_book) { create(:book_with_author) }
        let(:book) { { title: "new-title" } }
        let(:id) { example_book.id }

        schema type: :object,
               properties: book_properties, required: %w[id title author]

        run_test! do |response|
          body = JSON.parse(response.body)
          body['title'] == 'new-title'
        end
      end

      response '403', 'Validation errors' do
        let(:example_book) { create(:book_with_author) }
        let(:book) { {
          title: "more-than-128-letters-title-more-than-128-letters-title-more-than-128-letters-title-\
                  more-than-128-letters-title-more-than-128-letters-title-more-than-128-letters-title"
        } }
        let(:id) { example_book.id }

        schema type: :object,
               properties: {
                 error: { type: :object }
               },
               required: %w[error]

        run_test!
      end
    end
  end

  path '/api/books/{id}' do
    delete "Show book details" do
      let(:book) { create(:book_with_author) }

      before do
        book
      end

      tags 'Books'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'Deleted' do
        let(:id) { book.id }

        run_test!
      end

      response '404', 'Record not found' do
        let(:id) { 999 }

        run_test!
      end

    end
  end

end
