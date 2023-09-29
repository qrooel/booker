# frozen_string_literal: true

module Entities
  class Base < Grape::Entity
    include Rails.application.routes.url_helpers

    def url_options
      Booker::Application.config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    end
  end
end
