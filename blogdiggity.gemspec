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
  s.test_files  = `git ls-files -- spec/*`.split("\n")

  s.add_dependency 'rails', '>=  3.2'
  
  s.add_dependency 'omniauth', '~> 1.1'
  s.add_dependency 'omniauth-github', '~> 1.1'
  s.add_dependency 'github_api', '~> 0.9'
  s.add_dependency 'asciidoctor', '~> 0.1'
  s.add_dependency 'jquery-rails', '~> 2.2'
  s.add_dependency 'sass-rails', '~> 4.0.0'
  s.add_dependency 'bootstrap-sass', '~> 3.1.0'
  s.add_dependency 'coffee-rails', '~> 4.0.0'
  s.add_dependency 'font-awesome-sass-rails', ['~> 3.0', '>= 3.0.0.1']
  s.add_dependency 'pingr', '~> 0.0.3'
 
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 2.12.2'
  s.add_development_dependency 'forward', '~> 0.3.1'
  s.add_development_dependency 'rails-boilerplate', '~> 0.1'
  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'selenium-webdriver', '~> 2'
  s.add_development_dependency 'shoulda-matchers', '~> 2.0'
end
