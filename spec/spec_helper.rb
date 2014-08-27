ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'fabrication'
require 'database_cleaner'
require 'faker'
require 'pry'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

OmniAuth.config.test_mode = true

RSpec.configure do |config|
  Fabrication.configure do |config|
    config.path_prefix = ENGINE_RAILS_ROOT
  end

  config.include(OmniauthMacros)
  config.include(ControllerMacros, :type => :controller)

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end



  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.before(:all, callbacks: true) do
    ActiveRecord::Base.skip_callbacks = false
  end
  
  config.after(:all, callbacks: true) do
    ActiveRecord::Base.skip_callbacks = true
  end

  ActiveRecord::Base.skip_callbacks = true
end

