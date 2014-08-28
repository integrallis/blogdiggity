require 'base64'

module Blogdiggity
  class Repository < ActiveRecord::Base
    attr_accessor :root_url
    
    belongs_to :contributor
    has_many :pages 

    #TODO Need to refactor this 
    before_create(:set_sha) if Rails.env.development? || Rails.env.production?
    after_create(:configure) if Rails.env.development? || Rails.env.production?
    before_create(:set_sha, unless: :skip_callbacks) if Rails.env.test?
    after_create(:configure, unless: :skip_callbacks) if Rails.env.test?
    
    ASCIIDOC_EXTENSIONS = ['.asciidoc', '.asc', '.txt']


    def page_paths
      all = []
      self.contributor.git.git_data.trees.get contributor.nickname, self.name, self.sha, :recursive => true do |file|
        ext = File.extname(file.path).downcase
        all << file.path if ASCIIDOC_EXTENSIONS.include?(ext) && !file.path.match(/^README/)
      end
      all
    end
   
    private
    def set_sha
      begin   
        head_ref = self.contributor.git.git_data.references.get(self.contributor.nickname, self.name, 'heads/master')
        self.sha = head_ref[:object][:sha]
      rescue Github::Error::ServiceError => e
        self.contributor.git.repos.contents.create(self.contributor.nickname, self.name, 'README.asc', path: '', content: 'An initial commit was made by blogdiggity in order to add this repo since it was empty.', message: 'Initial commit made by blogdiggity.') 
        head_ref = self.contributor.git.git_data.references.get(self.contributor.nickname, self.name, 'heads/master')
        self.sha = head_ref[:object][:sha]
      end
    end

   def configure
      # create pages
      page_paths.each do |path|
        ext = File.extname(path)
        slug = path.chomp(ext)
        self.pages.create(:slug => slug, :extension => ext, :published => false)
      end
      
      # setup web hook 
      unless (self.contributor.git.repos.hooks.list(self.contributor.nickname, self.name).empty? == false) 
        callback_url = "#{self.root_url}#{Blogdiggity::Engine.routes._generate_prefix({})}/repository/#{self.name}/webhook"
        self.contributor.git.repos.hooks.create( 
              self.contributor.nickname, 
        self.name,
        { "name" => "web", 
          "active" => true, 
          "config" => { "url" => callback_url, "content_type" => "json" }
        }
        )
      end
    end
  end
end
