class RemoveHasReadColumnFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :has_read, :boolean, default: false
  end
end
