# frozen_string_literal: true

module Entities
  class AuthorFull < AuthorBase
    expose :books, using: Entities::BookMini, as: :books
  end
end
