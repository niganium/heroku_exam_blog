Rails.application.routes.draw do
  resources :contacts
  get 'sessions/new'

  get '/', to: "home#top"
  get '/about', to: "home#about"
  resources :blogs
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new,:create, :show]
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
