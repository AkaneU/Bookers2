Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:index, :new, :create, :show, :destroy]
  resources :homes

  resources :users, only: [:show, :index, :edit, :update]
end
