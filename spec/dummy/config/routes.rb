Rails.application.routes.draw do
  mount Blogdiggity::Engine => "/blog", as: "blog"
  root :to => redirect("/blog/pages")
end
