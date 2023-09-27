# frozen_string_literal: true

module Entities
  class Author < Base
    expose :id
    expose :first_name
    expose :last_name
    expose :genre

    expose :books, using: Entities::Book, as: :books
  end
end
