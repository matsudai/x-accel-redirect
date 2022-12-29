Rails.application.routes.draw do
  namespace :public do
    resources :download, only: :index
  end
  namespace :storage do
    resources :download, only: :index
  end
end
