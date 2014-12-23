require 'omniauth-github'
require 'github_api'

require 'bootstrap-sass'
require 'font-awesome-sass-rails'
require 'jquery-rails'
require 'pingr'
require 'asciidoctor'
require 'figaro'

module Blogdiggity
  class Engine < ::Rails::Engine
    isolate_namespace Blogdiggity

    config.generators do |g|
      g.test_framework      :rspec, :fixture => false
      g.fixture_replacement :fabrication, :dir => 'spec/fabricators'
      g.assets false
      g.helper false
    end
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
