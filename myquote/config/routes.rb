Rails.application.routes.draw do
  resources :quote_categories
  resources :categories
  resources :authors
  resources :quotes
  resources :users
  #get 'about/index'
  #get 'home/index'

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  get '/about', to: 'about#index'
  get '/admin', to: 'home#aindex'
  get '/userhome', to: 'home#uindex'
  get '/your-quotes', to: 'home#uquotes'
  get 'search', to: 'search#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
