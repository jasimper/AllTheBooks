Rails.application.routes.draw do
  devise_for :users

  root 'books#index'

  resources :books do
    collection do
      get 'search', action: 'search'
      post 'add_gbook', action: 'add_gbook'
    end
    member do
      get :add_book
    end
  end

  resources :user_books do
    member do
      patch :has_read
      get :new_note
      patch :add_note
    end
  end

  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    post '/login' => 'devise/sessions#create'
    get '/logout' => 'devise/sessions#destroy'

    get '/signup' => 'devise/registrations#new'
    post '/users' => 'devise/registrations#create'
  end

  concern :noteable do
    resources :notes
  end

  resources :books, concerns: :noteable
  resources :events, concerns: :noteable

end
