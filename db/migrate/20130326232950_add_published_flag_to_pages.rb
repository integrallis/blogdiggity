class AddPublishedFlagToPages < ActiveRecord::Migration
  def change
    add_column :blogdiggity_pages, :published, :boolean
    add_column :blogdiggity_pages, :published_at, :datetime
  end
end
