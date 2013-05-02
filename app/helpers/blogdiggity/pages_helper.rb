module Blogdiggity
  module PagesHelper
    def url_for_page(page)
      "#{root_url}#{page.slug}"
    end
    
    def current_page
      @page
    end
    
  end
end


