class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :kind

      t.timestamps null: false
    end
  end
end
