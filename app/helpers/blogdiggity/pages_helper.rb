module Blogdiggity
  module PagesHelper
    def url_for_page(page)
      "#{root_url}#{page.slug}"
    end
    
  end
end


