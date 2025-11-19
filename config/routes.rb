Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root 'items#index' # This makes it the homepage

  get 'items/new', to: 'items#new'

  resources :items, only: [:index, :new, :create, :show]
end
