# frozen_string_literal: true

module Entities
  class Book < Base
    expose :id
    expose :title
    expose :data
    expose :cover_link

    # expose :author, using: Entities::Author, as: :author

    def cover_link
      ""
    end
  end
end
