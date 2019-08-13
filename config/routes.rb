Rails.application.routes.draw do
  root "users#index"
  resources :users
  resources :events
  resources :sessions
  get "/sign_up",to:"users#new"
  get "/login",to:"sessions#new"
  post "/login",to:"sessions#create"
  get "/logout",to:"sessions#destroy"
end

