ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/spec'
require 'minitest/mock'
require 'sidekiq/testing'
require 'spy/integration'

class ActiveSupport::TestCase
  extend Minitest::Spec::DSL
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
