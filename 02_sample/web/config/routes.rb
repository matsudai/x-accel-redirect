Rails.application.routes.draw do
  namespace :private do
    resources :upload, only: :create
  end
  namespace :public do
    resources :download, only: :index
    resources :upload, only: :create
  end
  namespace :storage do
    resources :download, only: :index
    resources :upload, only: :create
  end
end
