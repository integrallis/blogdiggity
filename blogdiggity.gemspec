$:.push File.expand_path('../lib', __FILE__)

require 'blogdiggity/version'

Gem::Specification.new do |s|
  s.name        = 'blogdiggity'
  s.version     = Blogdiggity::VERSION
  s.authors     = ['Brian Sam-Bodden', 'Danny Whalen']
  s.email       = ['bsbodden@integrallis.com', 'dwhalen@integrallis.com']
  s.homepage    = 'https://github.com/integrallis/blogdiggity'
  s.summary     = 'A Rails 3 & 4 Blog Engine Powered by Git'
  s.description = 'Blogdiggity; A Rails 3 & 4 Blog Engine Powered by Git'

  s.files       = `git ls-files`.split("\n")
  s.test_files = Dir["spec/**/*"]
  #  s.test_files  = `git ls-files -- spec/*`.split("\n")
  s.add_dependency 'rails', '>= 3.2' 
  
  s.add_dependency 'omniauth-github'
  s.add_dependency 'github_api'
  s.add_dependency 'asciidoctor' 
  s.add_dependency 'jquery-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'bootstrap-sass', '>= 2.3.0'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'font-awesome-sass-rails', ['~> 3.0', '>= 3.0.0.1']
  s.add_dependency 'pingr', '~> 0.0.3'
  s.add_dependency 'pg'
  s.add_dependency 'activerecord-postgresql-adapter'
  s.add_dependency 'unicorn'
  s.add_dependency 'figaro'
  s.add_dependency 'uglifier' 

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.0.0' 
  s.add_development_dependency 'forward', '~> 0.3.1'
  s.add_development_dependency 'rails-boilerplate', '~> 0.1'
  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'selenium-webdriver', '~> 2'
  s.add_development_dependency 'shoulda-matchers', '2.6.2'
  s.add_development_dependency 'fabrication'
  s.add_development_dependency 'faker', '~> 1.4.3' 
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'database_cleaner', '~> 1.3.0'
end
