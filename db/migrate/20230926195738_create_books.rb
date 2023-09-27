class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :cover
      t.jsonb :data, default: {}
      t.integer :author_id

      t.timestamps
    end
  end
end
