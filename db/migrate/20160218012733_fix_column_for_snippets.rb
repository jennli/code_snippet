class FixColumnForSnippets < ActiveRecord::Migration
  def change
    rename_column :snippets, :work, :body
  end
end
