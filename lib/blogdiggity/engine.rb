require 'omniauth'
require 'omniauth-github'
require 'github_api'

require 'bootstrap-sass'
require 'font-awesome-sass-rails'
require 'jquery-rails'
require 'pingr'
require 'asciidoctor'
require 'pry-rails'
require 'figaro'
require 'fabrication'

module Blogdiggity
  class Engine < ::Rails::Engine
    isolate_namespace Blogdiggity
    
    config.generators do |g|
      g.test_framework      :rspec, :fixture => false
      g.fixture_replacement :fabrication, :dir => 'spec/fabricators'
      g.assets false
      g.helper false
    end

  end
end
