require 'bundler/setup'
require 'dry/templates'
require 'rails/all'

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

module TestApp
  class Application < Rails::Application
    config.root = File.dirname(__FILE__)
  end
end

require 'ammeter/init'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
