class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event
      t.integer :user_id
      t.date :release_date

      t.timestamps null: false
    end
    add_index :event, :user_id
  end
end
