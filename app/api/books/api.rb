# frozen_string_literal: true

module Books
  class API < Grape::API
    prefix :api
    format :json
    content_type :json, 'application/json'

    rescue_from ActiveRecord::RecordNotFound do
      error!('Record not found', 404)
    end

    rescue_from :all do |e|
      error!(e.message, 500)
    end

    # http://localhost:3000/api/books
    resource :books do
      desc "List books"
      get do

        {}
        # present @current_user.attachments, with: Entities::Attachment
      end

      desc 'Book details'
      params do
        requires :id, type: Integer
      end
      get ":id" do
        {det: true}
      end

      desc 'Create book'
      params do
      end
      post do
      end

      desc 'Update book'
      params do
        requires :id, type: Integer
      end
      put do
      end

      desc 'Delete book'
      params do
        requires :id, type: Integer
      end
      delete do
      end
    end

  end
end
