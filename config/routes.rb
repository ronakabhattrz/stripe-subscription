Rails.application.routes.draw do
  resources :subscriptions, only: [:index, :create]
  devise_for :users
  root 'subscriptions#index'
end
