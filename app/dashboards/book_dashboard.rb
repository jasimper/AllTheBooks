require "administrate/base_dashboard"

class BookDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user_books: Field::HasMany,
    users: Field::HasMany,
    genre: Field::BelongsTo,
    format: Field::BelongsTo,
    id: Field::Number,
    isbn: Field::String,
    authors: Field::String,
    title: Field::String,
    description: Field::Text,
    published_date: Field::DateTime,
    image_link: Field::String,
    series: Field::Boolean,
    series_number: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    edittable: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :users,
    :id,
    :authors,
    :title,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user_books,
    :users,
    :genre,
    :format,
    :id,
    :isbn,
    :authors,
    :title,
    :description,
    :published_date,
    :image_link,
    :series,
    :series_number,
    :created_at,
    :updated_at,
    :edittable,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user_books,
    :users,
    :genre,
    :format,
    :isbn,
    :authors,
    :title,
    :description,
    :published_date,
    :image_link,
    :series,
    :series_number,
    :edittable,
  ].freeze

  # Overwrite this method to customize how books are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(book)
  #   "Book ##{book.id}"
  # end
end
