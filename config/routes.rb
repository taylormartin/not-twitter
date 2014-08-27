Rails.application.routes.draw do
  devise_for :users

  resources :tweets

  # namespace :api
  get "api/tweets" => "tweets#index"

  root to: "tweets#index"
end
