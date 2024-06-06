Rails.application.routes.draw do
  resources :rentals, only: [:index, :show, :destroy] do
    patch 'approve', to: 'rentals#approve', as: 'approve'
    patch 'decline', to: 'rentals#decline', as: 'decline'

  end
  devise_for :users
  root to: "pages#home"

  resources :items do
    collection do
      get 'search', to: 'items#index'
    end
    resources :rentals, only: [:new, :create, :edit, :update]
    resources :reviews, only: [:new, :create]
  end
end
