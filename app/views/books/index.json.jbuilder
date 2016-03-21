json.array!(@books) do |book|
  json.extract! book, :id, :isbn, :author, :title, :description, :pub_date, :genre_id, :format_id, :image_url, :has_read, :series, :series_num
  json.url book_url(book, format: :json)
end
