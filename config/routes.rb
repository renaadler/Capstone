Rails.application.routes.draw do
  get "/signup" => "users#new"
  post "/users" => "users#create"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/" => "relationships#index"
  get "/connections" => "relationships#index"
  get "/connections/:id" => "relationships#show"
end
