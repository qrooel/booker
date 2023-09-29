# frozen_string_literal: true

module Entities
  class BookBase < Base
    expose :id
    expose :title
    expose :data
    expose :cover_link

    def cover_link
      base_url = books_api_url(url_options)

      "#{base_url}/api/books/#{object.id}/cover"
    end
  end
end
