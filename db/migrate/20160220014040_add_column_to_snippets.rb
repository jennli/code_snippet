class AddColumnToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :is_private, :string
  end
end
