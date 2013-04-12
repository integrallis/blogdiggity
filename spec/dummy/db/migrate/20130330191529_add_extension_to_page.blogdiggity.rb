# This migration comes from blogdiggity (originally 20130330185759)
class AddExtensionToPage < ActiveRecord::Migration
  def change
    add_column :blogdiggity_pages, :extension, :string
  end
end
