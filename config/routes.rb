Rails.application.routes.draw do
  devise_for :users
 resources :books
 root 'books#index'
 get '/search', to: 'searches#search'
 post '/search', to: 'searches#google_books'
 post '/search/books/:id', to: 'searches#book'

end
