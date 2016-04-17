class RenameColumnsBookTable < ActiveRecord::Migration
  def change
    rename_column :books, :author, :authors
    rename_column :books, :pub_date, :published_date
    rename_column :books, :image_url, :image_link
    rename_column :books, :series_num, :series_number
  end
end
