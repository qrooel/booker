# frozen_string_literal: true

module Authors
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
    resource :authors do
      desc "List authors"
      params do
        use :pagy
      end
      get do
        present pagy(Author.all), with: Entities::AuthorFull
      end

      desc 'Author details'
      params do
        requires :id, type: Integer
      end
      get ":id" do
        present Author.find(params[:id]), with: Entities::AuthorFull
      end

      desc 'Create author'
      params do
        requires :first_name, type: String
        requires :last_name, type: String
        requires :genre, type: String
      end
      post do
        author = Author.create!(declared(params))

        present author, with: Entities::AuthorFull
      end

      desc 'Update author'
      params do
        requires :id, type: Integer
        optional :first_name, type: String
        optional :last_name, type: String
        optional :genre, type: String
      end
      put ":id" do
        author = Author.find(params[:id])

        author.update!(declared(params).except(:id))

        present author, with: Entities::AuthorFull
      end

      desc 'Delete author'
      params do
        requires :id, type: Integer
      end
      delete ':id' do
        author = Author.find(params[:id])
        author.delete

        status 204
      end
    end

  end
end
