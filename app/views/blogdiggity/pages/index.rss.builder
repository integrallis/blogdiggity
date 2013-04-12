xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "htt://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title "#{Rails.application.engine_name.titleize} Blog Posts"
    xml.description "#{Rails.application.engine_name.titleize} Blog Posts"
    xml.pubDate CGI.rfc1123_date @pages.first.try(:published_at)
    xml.link root_url
    xml.lastBuildDate CGI.rfc1123_date @pages.first.try(:published_at)
    xml.language I18n.locale

    @pages.each do |page|
      
      if page.published?
        xml.item do
          xml.title page.slug.titleize
          xml.description page.summary.html_safe
          xml.link url_for_page(page)
          xml.pubDate CGI.rfc1123_date(page.published_at)
          xml.guid url_for_page(page)
          xml.author page.repository.contributor.name
        end
      end
    end
  end
end
