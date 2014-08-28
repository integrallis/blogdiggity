module Blogdiggity
  class Contributor < ActiveRecord::Base
    
    has_many :repositories
    
    def git
      Github.new oauth_token: self.token
    end

    def to_s
      "#{self.name} (#{self.nickname})"
    end
    
    def repos
      self.git.repos.all
    end
  end
end
