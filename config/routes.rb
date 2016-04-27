Rails.application.routes.draw do

  namespace :admin do
    resources :users
resources :user_books
resources :books
resources :events
resources :formats
resources :genres
resources :notes

    root to: "users#index"
  end

  devise_for :users

  root 'books#index'

  resources :books do
    collection do
      get 'search', action: 'search'
      post 'add_gbook', action: 'add_gbook'
    end
    member do
      post :add_book
    end
  end

  resources :user_books, except: [:index, :show, :new, :create, :edit] do
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
