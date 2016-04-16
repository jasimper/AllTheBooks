class AddUniqueIndexToUserBooks < ActiveRecord::Migration
  def change
    remove_index :user_books, [:user_id, :book_id]
    add_index :user_books, [:user_id, :book_id], unique: true
  end
end
