# frozen_string_literal: true

module Entities
  class BookBase < Base
    expose :id
    expose :title
    expose :data
    expose :cover_link

    def cover_link
      ""
    end
  end
end
