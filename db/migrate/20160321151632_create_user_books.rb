class CreateUserBooks < ActiveRecord::Migration
  def change
    create_table :user_books do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps null: false
    end

    add_index :user_books, [:user_id, :book_id]
  end
end
