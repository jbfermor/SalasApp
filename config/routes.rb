Rails.application.routes.draw do
  resources :reservations
  resources :rooms
  resources :teches
  
  post "/users", to: "users#create"
  delete "/users/:id", to: "users#destroy"
  
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
