# frozen_string_literal: true

module Entities
  class AuthorBase < Base
    expose :id
    expose :first_name
    expose :last_name
    expose :genre
  end
end
