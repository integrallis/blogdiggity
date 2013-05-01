class Blogdiggity::ApplicationController < ApplicationController
  protect_from_forgery
  helper_method :current_contributor
  
  private
  
  def current_contributor
    @contributor ||= Contributor.find(session[:contributor_id]) if session[:contributor_id]
  end
end

