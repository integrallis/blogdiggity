xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.urlset(:xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9") do
  @pages.each do |page|
    if page.published?
      xml.url do
        xml.loc url_for_page(page)
        xml.lastmod page.published_at.strftime('%Y-%m-%e')
      end
    end
  end
end