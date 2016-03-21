class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :author, null: false
      t.string :title, null: false
      t.text :description
      t.date :pub_date
      t.integer :genre_id
      t.integer :format_id
      t.string :image_url
      t.boolean :has_read, default: false
      t.boolean :series, default: false
      t.float :series_num

      t.timestamps null: false
    end
    add_index :books, [:genre_id, :format_id]
  end
end
