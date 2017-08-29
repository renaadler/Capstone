
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/relationships' => "relationships#index"
      # patch '/relationships/:id' => "relationships#update"
    end
  end

  get "/users/" => "users#index"
  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/users/:id" => "users#show"
  get "/users/:id/edit" => "users#edit"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  get "/pending" => "relationships#pending"
  patch "/pending" => "relationships#pending_update"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/" => "relationships#index"
  get "/relationships" => "relationships#index"
  post "/relationships" => "relationships#create"
  get "/relationships/:id" => "relationships#show"
  patch "/relationships/:id" => "relationships#update"

end
