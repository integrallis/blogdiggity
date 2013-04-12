class AddExtensionToPage < ActiveRecord::Migration
  def change
    add_column :blogdiggity_pages, :extension, :string
  end
end
