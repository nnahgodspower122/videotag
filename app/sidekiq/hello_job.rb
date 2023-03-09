# frozen_string_literal: true

class HelloJob
  include Sidekiq::Job

  def perform(*_args)
    Rails.logger.debug 'Hello world!'
  end
end
