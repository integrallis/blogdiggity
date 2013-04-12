require_dependency "blogdiggity/application_controller"
require 'open-uri'

module Blogdiggity
  class ContributorsController < ApplicationController
    def index
      @contributors = Contributor.all

      respond_to do |format|
        format.html
      end
    end

    def new
      redirect_to "#{root_path}auth/github" 
    end

    def create
      auth = request.env["omniauth.auth"]

      @contributor = Contributor.find_or_create_by_provider_and_uid(:provider => auth['provider'], :uid => auth['uid'].to_s)
      @contributor.update_attributes(
        :name => auth['info']['name'] || '',
        :email => auth['info']['email'] || '',
        :nickname => auth['info']['nickname'] || '',
        :image => auth['info']['image'] || '',
        :github_url => auth['info']['urls']['GitHub'] || '',
        :token => auth['credentials']['token'] || '',
        :repos_url => auth['extra']['raw_info']['repos_url'] || '',
        :company => auth['extra']['raw_info']['company'] || '',
        :location => auth['extra']['raw_info']['location'] || ''
      ) 
      session[:contributor_id] = @contributor.id
      respond_to do |format|
        format.html { redirect_to @contributor, notice: 'Contributor was successfully added.' }
      end
    end

    def show
      contributor = Contributor.find(params[:id])
      if contributor == current_contributor
        @repos = contributor.repos
        respond_to do |format|
          format.html # show.html.erb
        end
      else
        redirect_to({:action => :index}, {:alert => "<strong>Hey!</strong> You are not allow to see other contributors' repositories!".html_safe})
      end
    end

    def destroy
      @contributor = Contributor.find(params[:id])
      @contributor.destroy

      respond_to do |format|
        format.html { redirect_to contributors_url }
      end
    end

    def failure
      redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
    end

    def add_repo
      @contributor = Contributor.find(params[:contributor_id])
      @contributor.repositories.create(:name => params[:repo_name], :root_url => root_url)
      redirect_to @contributor
    end

    def remove_repo
      @contributor = Contributor.find(params[:contributor_id])
      repository = Repository.find_by_name(params[:repo_name])
      repository.destroy

      redirect_to @contributor
    end
    
    def signout
      session[:contributor_id] = nil
      redirect_to root_url, :notice => "Signed out!"
    end
    
    # repo webhook handler
    def webhook
      @repository = Repository.find_by_name(params[:repo_name])
      push = Hashie::Mash.new(params)
      push.commits.each do |commit|
        # processing added files - create new pages
        commit.added.each do |path|
          @repository.pages.create(:slug => path)
        end if commit.added
        
        # processing removed files - delete corresponding page entry
        commit.removed.each do |path|
          @repository.pages.where(:slug => path).destroy
        end if commit.removed
        
        # processing modified files - invalidate the cache cached 
        commit.modified.each do |path|
          Rails.cache.delete(path)
          page = Page.find_by_slug(path)
          page.touch
        end if commit.modified
        
        puts ">>>>>>>>>>>>>>"
        puts "timestamp ==> #{commit.timestamp}"
        puts "added ==> #{commit.added}" # ===> call repo.pages.create(:slug => path)
        puts "removed ==> #{commit.removed}" # ===> call Page.find_by_slug("#{params[:page]}.asciidoc").delete
        puts "modified ==> #{commit.modified}" # ===> call Rails.cache.delete(path)
        puts "author ==> #{commit.author}" # might need to rethink multi-authoring?
        puts "<<<<<<<<<<<<<<"
      end
      render :nothing => true, :status => 200
    end
    
  end
end
