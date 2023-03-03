class HelloJob
  include Sidekiq::Job

  def perform(*_args)
    puts 'Hello world!'
  end
end
