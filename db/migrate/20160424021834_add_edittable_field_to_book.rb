class AddEdittableFieldToBook < ActiveRecord::Migration
  def change
    add_column :books, :edittable, :boolean
  end
end
