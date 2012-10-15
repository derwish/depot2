ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def assert_size(collection, size, message = nil)
    message ||= "expected #{collection.inspect} to have #{size} elements but instead had #{collection.size}"
    assert_block message do
      collection.size == size
    end
  end
  
  # Add more helper methods to be used by all tests here...
end
