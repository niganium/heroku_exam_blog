Rails.application.routes.draw do
  resources :contacts
  get 'sessions/new'

  get '/', to: "home#top"
  
  get '/about', to: "home#about"
  
  resources :blogs do
    collection do
      post :confirm
    end
  end
  
  resources :users do
    collection do
      post :confirm
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
