# This migration comes from blogdiggity (originally 20130326232950)
class AddPublishedFlagToPages < ActiveRecord::Migration
  def change
    add_column :blogdiggity_pages, :published, :boolean
    add_column :blogdiggity_pages, :published_at, :datetime
  end
end
