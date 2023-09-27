# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

describe Authors::API, type: :request do

  author_properties = {
    id: { type: :integer },
    first_name: { type: :string },
    last_name: { type: :string },
    genre: { type: :string },
    books: {
      type: :array,
      items: {
        properties: {
          id: { type: :integer },
          title: { type: :string },
          data: { type: :json },
          cover_link: { type: :string }
        }
      }
    }
  }

  path '/api/authors' do
    get "List authors" do #
      tags 'Authors'
      produces 'application/json'

      let(:author) { create(:author_with_books) }

      before do
        author
      end

      response '200', 'ok' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: author_properties, required: %w[id first_name last_name books]
               }

        run_test!
      end

    end
  end

  path '/api/authors/{id}' do
    get "Show author details" do
      let(:author) { create(:author_with_books) }

      before do
        author
      end

      tags 'Authors'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'ok' do
        schema type: :object,
               properties: author_properties, required: %w[id first_name last_name books]

        let(:id) { author.id }

        run_test!
      end

      response '404', 'Record not found' do
        let(:id) { 999 }

        run_test!
      end

    end
  end

  path '/api/authors' do
    post "Create author" do
      tags 'Authors'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          genre: { type: :string }
        },
        required: ['first_name', 'last_name', 'genre']
      }

      response '201', 'Created' do
        schema type: :object,
               properties: author_properties, required: %w[id first_name last_name books]

        let(:author) { { first_name: "Andrzej", last_name: "Kowalski", genre: "sf" } }

        run_test!
      end

      response '403', 'Validation errors' do
        schema type: :object,
               properties: {
                 error: { type: :object }
               },
               required: %w[error]

        let(:author) { {
          first_name: "more-than-32-letters-name-as-first-name",
          last_name: "more-than-32-letters-name-as-last-name",
          genre: "sf"
        } }

        run_test!
      end

      response '500', 'Params are missing' do
        let(:author) { { first_name: "Andrzej" } }

        run_test!
      end

    end
  end

  path '/api/authors/{id}' do
    put "Update author" do
      tags 'Authors'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          genre: { type: :string }
        },
        required: ['first_name', 'last_name', 'genre']
      }

      response '200', 'Updated' do
        let(:author) { create(:author) }
        let(:id) { author.id }

        schema type: :object,
               properties: author_properties, required: %w[id first_name last_name books]

        run_test!
      end

      response '403', 'Validation errors' do
        let(:example_author) { create(:author) }
        let(:author) { { first_name: "more-than-32-letters-name-as-first-name" } }
        let(:id) { example_author.id }

        schema type: :object,
               properties: {
                 error: { type: :object }
               },
               required: %w[error]

        run_test!
      end
    end
  end

  path '/api/authors/{id}' do
    delete "Show author details" do
      let(:author) { create(:author_with_books) }

      before do
        author
      end

      tags 'Authors'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'Deleted' do
        let(:id) { author.id }

        run_test!
      end

      response '404', 'Record not found' do
        let(:id) { 999 }

        run_test!
      end

    end
  end

end
