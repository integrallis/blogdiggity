class Blogdiggity::ApplicationController < ApplicationController
  protect_from_forgery
  helper_method :current_contributor, :active_contributor, :require_active_contributor
  
  private
  
  def current_contributor
    @contributor ||= Blogdiggity::Contributor.find(session[:contributor_id]) if session[:contributor_id]
  end

  def active_contributor
    current_contributor ? current_contributor.status == 'active' || 'admin' : false
  end

  def require_active_contributor
      redirect_to(root_path, {:alert => "<strong>Hey!</strong> You are not an active contributor!".html_safe}) if !active_contributor
  end

  def require_admin_contributor
    redirect_to(root_path, {:alert => "<strong>Hey!</strong> You are not authorized to do that!".html_safe}) if !active_contributor
  end
end

