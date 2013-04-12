# This migration comes from blogdiggity (originally 20130315234324)
class CreateBlogdiggityRepositories < ActiveRecord::Migration
  def change
    create_table :blogdiggity_repositories do |t|
      t.integer :contributor_id
      t.string :name
      t.string :sha

      t.timestamps
    end
  end
end
