require 'spec_helper'

describe Blogdiggity::ContributorsController, :type => :controller do


  describe "DELETE remove_repo" do

    it "should destroy pages associated with repo"  do

      contributor_login     
      @example_repo = @contributor.repositories.create(name: 'repo')     
      @example_repo.pages.create 
      
      delete :remove_repo, use_route: 'blogdiggity', contributor_id: @contributor.id, repo_name: 'repo' 
      expect(Blogdiggity::Page.count).to eq(0)
    end

  end
end

