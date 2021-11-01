Rails.application.routes.draw do
  get 'users/show'
  get 'home/about' => 'homes#about'
  devise_for :users
  root to: 'homes#top'

  resources :homes
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update]
end
