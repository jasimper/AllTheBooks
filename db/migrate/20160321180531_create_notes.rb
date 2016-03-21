class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :info
      t.integer :noteable_id
      t.string :noteable_type

      t.timestamps null: false
    end
    add_index :notes, :noteable_id
  end
end
