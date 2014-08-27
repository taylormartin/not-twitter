Rails.application.routes.draw do
  devise_for :users

  resources :tweets

  get "api/tweets" => "tweets#index"

  root to: "tweets#index"
end
