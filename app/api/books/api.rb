# frozen_string_literal: true

module Books
  class API < Grape::API
    helpers Grape::Pagy::Helpers

    prefix :api
    format :json
    content_type :json, 'application/json'

    rescue_from ActiveRecord::RecordNotFound do
      error!('Record not found', 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |error|
      error!({ error: error.record.errors.messages }, 403)
    end

    rescue_from :all do |e|
      error!(e.message, 500)
    end

    # http://localhost:3000/api/authors
    resource :books do
      desc "List books"
      params do
        use :pagy
      end
      get do
        present pagy(Book.all), with: Entities::BookFull
      end

      desc 'Book details'
      params do
        requires :id, type: Integer
      end
      get ":id" do
        present Book.find(params[:id]), with: Entities::BookFull
      end

      desc 'Create book'
      params do
        requires :book, type: Hash do
          requires :title, type: String
          requires :author_id, type: Integer
          requires :cover, type: File
        end
      end
      post do
        book = Book.create!(declared(params)[:book])

        present book, with: Entities::BookFull
      end

      desc 'Update book'
      params do
        requires :id, type: Integer
        optional :title, type: String
      end
      put ":id" do
        book = Book.find(params[:id])

        book.update!(declared(params).except(:id))

        present book, with: Entities::BookFull
      end

      desc 'Delete book'
      params do
        requires :id, type: Integer
      end
      delete ':id' do
        book = Book.find(params[:id])
        book.delete

        status 204
      end
    end

  end
end
