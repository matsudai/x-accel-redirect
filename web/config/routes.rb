Rails.application.routes.draw do
  resources :private_files, only: [:show]
  resources :auth_verify, only: [:index]
  resources :internal_files, only: [:index]
  resources :external_files, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
