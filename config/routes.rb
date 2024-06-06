Rails.application.routes.draw do
  resources :rentals, only: [:index, :show, :destroy] do
    member do
      patch 'approve'
      patch 'decline'
    end
  end
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :items do
    collection do
      get 'search', to: 'items#index'
    end
    resources :rentals, only: [:new, :create, :edit, :update]
    resources :reviews, only: [:new, :create]
  end
end
