Rails.application.routes.draw do
  devise_for :users

  resources :tweets
  resources :profiles

  root to: "static_pages#home"

  # namespace :api
  get "api/tweets" => "tweets#index"

end
