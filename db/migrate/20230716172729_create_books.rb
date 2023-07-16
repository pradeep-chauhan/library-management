class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.references :library, null: false, foreign_key: true
      t.boolean :available
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
