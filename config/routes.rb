Rails.application.routes.draw do
  get "/signup" => "users#new"
  post "/users" => "users#create"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/" => "relationships#index"
  get "/relationships" => "relationships#index"
  get "/relationships/:id" => "relationships#show"
end
