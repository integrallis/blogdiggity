Blogdiggity::Engine.routes.draw do
  resources :contributors
  
  post '/repository/:repo_name/webhook', :to => 'contributors#webhook', :as => :webhook
  
  resources :pages, :only => :index
  
  post '/seo/submit', :to => 'pages#seo_submit', :as => :seo_submit
  
  post '/contributors/:contributor_id/repository/add/:repo_name', :to => 'contributors#add_repo', :as => :add_contributor_repository
  delete '/contributors/:contributor_id/repository/remove/:repo_name', :to => 'contributors#remove_repo', :as => :remove_contributor_repository
  put '/contributors/:contributor_id/signout' => "contributors#signout", :as => :contributor_signout
  
  put '/page/:page/publish', :to => 'pages#publish', :as => :publish_page
  put '/page/:page/unpublish', :to => 'pages#unpublish', :as => :unpublish_page
  
  match '/auth/:provider/callback' => 'contributors#create', :as => :auth_callback
  match '/auth/failure' => 'contributors#failure', :as => :auth_failure
  root :to => "contributors#index"

  match "/pages/:year" => "pages#by_year", :constraints => { :year => /\d{4}/ }, :as => :pages_by_year
  match "/pages/:year/:month" => "pages#by_year_and_month", :constraints => { :year => /\d{4}/, :month => /\d{1,2}/ }, :as => :pages_by_year_and_month
  match "/pages/:year/:month/:page" => "pages#show_by_year_and_month", :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :page => /[a-z0-9\-]+/ }, :as => :show_pages_by_year_and_month
    
  match "/*page" => 'pages#show', :constraints => { :year => /\d{4}/, :month => /\d{1,2}/, :page => /[a-z0-9\-]+/ }
end
