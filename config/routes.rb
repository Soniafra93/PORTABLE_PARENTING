Rails.application.routes.draw do
  resources :rentals, only: [:show, :destroy, :index]
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :items do
    collection do
      get 'search', to: 'items#search'
    end
    resources :rentals, only: [:new, :create, :edit, :update]
    resources :reviews, only: [:new, :create]
  end
end
