Rails.application.routes.draw do
  resources :books
  devise_for :users

  root 'books#index'

  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    post '/login' => 'devise/sessions#create'
    get '/logout' => 'devise/sessions#destroy'

    get '/signup' => 'devise/registrations#new'
    post '/users' => 'devise/registrations#create'
  end

end
