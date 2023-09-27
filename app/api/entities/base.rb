# frozen_string_literal: true

module Entities
  class Base < Grape::Entity
    include Rails.application.routes.url_helpers

    def url_options
      Zipper::Application.config.action_mailer.default_url_options
    end
  end
end
