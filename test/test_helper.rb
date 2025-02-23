ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"
require "mocha/minitest"
require "webmock/minitest"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    VCR.configure do |config|
      config.cassette_library_dir = "fixtures/vcr_cassettes"
      config.hook_into :webmock
    end
    # Added this so I can use context blocks for better test spec descriptions
    class << self
      alias context describe
    end
  end
end
