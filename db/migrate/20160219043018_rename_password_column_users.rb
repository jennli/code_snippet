class RenamePasswordColumnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :password_giest, :password_digest
  end
end
