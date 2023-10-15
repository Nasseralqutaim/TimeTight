Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :update, :destroy]
  resources :call_sessions do
  resources :agenda_items, only: [:create, :index, :update, :destroy]
  resources :feedbacks, only: [:create]
  resources :recordings, only: [:create, :index]
  end

  resources :call_sessions do
  resources :agenda_items, only: [:create, :index, :update, :destroy]
  resources :feedbacks, only: [:create, :show, :update, :destroy]
  resources :recordings, only: [:create, :index]
  end
  post "/sessions" => "sessions#create"
  get "up" => "rails/health#show", as: :rails_health_check
end
