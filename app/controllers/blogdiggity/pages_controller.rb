module Blogdiggity
  class PagesController < ApplicationController
    unloadable

    def show
      @page = Page.find_by_slug(params[:page])
      expires_in(5.minutes, public: true) unless Rails.env == "development"
      if @page && stale?(:etag => @page, :last_modified => @page.updated_at, :public => true)
        if @page.published? || Rails.env == "development"
          rendered_page = Rails.cache.fetch(@page.slug) do
            @page.rendered
          end
          
          render :text => rendered_page, :layout => 'application'
        else
          redirect_to :status => 404
        end
      else
        redirect_to :status => 404
      end
    end
  
    def index
      @pages = Page.all

      respond_to do |format|
        format.html
        format.xml
        format.rss
      end
    end
    
    def publish
      page = Page.find(params[:page])
      page.update_attributes(:published => true, :published_at => Time.now)
      
      redirect_to({:action => :index}, {:notice => "<strong>Congrats!</strong> You just published <strong>#{page.title}</strong>!".html_safe})
    end
    
    def unpublish
      page = Page.find(params[:page])
      page.update_attributes(:published => false)
      
      redirect_to({:action => :index}, {:alert => "<strong>Watch out!</strong> You just un-published <strong>#{page.title}</strong>!".html_safe})
    end
    
    def by_year
      @pages = params[:year] ? Page.by_year_and_month(params[:year].to_i) : []
      render :index
    end    
    
    def by_year_and_month
      @pages = (params[:year] && params[:month]) ? Page.by_year_and_month(params[:year].to_i, params[:month].to_i) : []
      render :index
    end

    def show_by_year_and_month
      pages = (params[:year] && params[:month]) ? Page.by_year_and_month(params[:year].to_i, params[:month].to_i) : []
      @page = pages.find_by_slug(params[:page])
      expires_in(5.minutes, public: true) unless Rails.env == "development"
      if @page && stale?(:etag => @page, :last_modified => @page.updated_at, :public => true)
        if @page.published? || Rails.env == "development"
          rendered_page = Rails.cache.fetch(@page.slug) do
            @page.rendered
          end
          
          render :text => rendered_page, :layout => true
        else
          redirect_to :status => 404
        end
      else
        redirect_to :status => 404
      end
    end
    
    # submit site map to all supported search engines
    def seo_submit
      for search_engine in ::Pingr::SUPPORTED_SEARCH_ENGINES
        ::Pingr::Request.new(search_engine, pages_url(format: :xml)).ping
      end
      
      redirect_to({:action => :index}, {:notice => '<strong>Yay!</strong> Sitemap XML has been submitted to all supported search engines!'.html_safe})
    end

  end
end
