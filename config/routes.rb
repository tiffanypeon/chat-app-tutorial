Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :memberships, only: [:create, :destroy]
  resources :conversations, only: [:create] do
    member do
      post :close
    end
  end
end
