# frozen_string_literal: true

module Entities
  class BookFull < BookBase

    expose :author, using: Entities::AuthorMini, as: :author

  end
end
