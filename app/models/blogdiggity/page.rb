module Blogdiggity
  class Page < ActiveRecord::Base
    #attr_accessible :repository_id, :slug, :published, :published_at, :extension
    
    belongs_to :repository
    
    scope :published, where(:published => true)
    scope :unpublished, where(:published => false)
    
    def self.by_year_and_month(year = Time.now.year, month = nil)
      dt = month ? DateTime.new(year, month) : DateTime.new(year)
      if month
        boy = dt.beginning_of_month
        eoy = dt.end_of_month
      else
        boy = dt.beginning_of_year
        eoy = dt.end_of_year
      end
      where("published_at >= ? and published_at <= ?", boy, eoy)
    end

    def content
      repo = self.repository
      owner = repo.contributor

      content_response = owner.git.repos.contents.get owner.nickname, repo.name, artifact_path
      Base64.decode64(content_response.content)
    end
    
    def rendered
      Asciidoctor.render(content)
    end
    
    def summary
      # look for abstract/summary in body
      ActionView::Base.full_sanitizer.sanitize(rendered).gsub(/\s+/, ' ')[0...250]
    end
    
    def title
      # look for the title in the body if not found default to filename titleized
      slug.titleize
    end
    
    def artifact_path
      slug + extension
    end

  end
end
