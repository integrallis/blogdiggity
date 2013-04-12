class CreateBlogdiggityContributors < ActiveRecord::Migration
  def change
    create_table :blogdiggity_contributors do |t|
      t.string :company
      t.string :email
      t.string :github_url
      t.string :image
      t.string :location
      t.string :name
      t.string :name
      t.string :nickname
      t.string :provider
      t.string :repos_url
      t.string :token
      t.string :uid

      t.timestamps
    end
    
    add_index :blogdiggity_contributors, :nickname, :unique => true
  end
end
