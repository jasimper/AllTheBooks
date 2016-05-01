# genre_list = [
#   "Art",
#   "Biography",
#   "Business",
#   "Chick Lit",
#   "Children's",
#   "Christian",
#   "Classics",
#   "Comics",
#   "Contemporary",
#   "Cookbooks",
#   "Crime",
#   "Fantasy",
#   "Fiction",
#   "Gay and Lesbian",
#   "Graphic Novels",
#   "Historical Fiction",
#   "History",
#   "Horror",
#   "Humor and Comedy",
#   "Manga",
#   "Memoir",
#   "Music",
#   "Mystery",
#   "Nonfiction",
#   "Paranormal",
#   "Philosophy",
#   "Poetry",
#   "Psychology",
#   "Religion",
#   "Romance",
#   "Science",
#   "Science Fiction",
#   "Self Help",
#   "Suspense",
#   "Spirituality",
#   "Sports",
#   "Thriller",
#   "Travel",
#   "Young Adult"
# ]
#
# genre_list.each do |genre|
#   Genre.create(genre: genre)
# end
#
# format_list = [
#   "Hardcover",
#   "Paperback",
#   "eBook",
#   "Spiralbound",
#   "Audiobook"
# ]
#
# format_list.each do |format|
#   Format.create(format: format)
# end
User.create(name: 'original', email: 'o@email.com', password: 'password', password_confirmation: 'password', admin: true)
