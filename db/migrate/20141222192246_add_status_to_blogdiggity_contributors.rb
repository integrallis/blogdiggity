class AddStatusToBlogdiggityContributors < ActiveRecord::Migration
  def change
    add_column :blogdiggity_contributors, :status, :string, default: 'pending', null: false   
  end
end
