class CreateBlogdiggityPages < ActiveRecord::Migration
  def change
    create_table :blogdiggity_pages do |t|
      t.integer :repository_id
      t.string :slug

      t.timestamps
    end
    
    add_index :blogdiggity_pages, :slug, :unique => true
  end
end
