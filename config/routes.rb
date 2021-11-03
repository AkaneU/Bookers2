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
  
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
end
