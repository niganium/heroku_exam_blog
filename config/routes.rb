Rails.application.routes.draw do
  get 'sessions/new'

  get '/', to: "home#top"
  get '/about', to: "home#about"
  resources :blogs
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new,:create, :show]
  resources :favorites, only: [:create, :destroy]
end
