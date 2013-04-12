require 'omniauth'
require 'omniauth-github'
require 'github_api'

require 'bootstrap-sass'
require 'font-awesome-sass-rails'
require 'jquery-rails'
require 'pingr'
require 'asciidoctor'

module Blogdiggity
  class Engine < ::Rails::Engine
    isolate_namespace Blogdiggity
  end
end
