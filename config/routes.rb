Rails.application.routes.draw do
  resources :users, only: [:create, :show, :update, :destroy] 
  resources :call_sessions do
    resources :agenda_items, only: [:create, :index, :update, :destroy]
    resources :feedbacks, only: [:create]
    resources :recordings, only: [:create, :index]
  end

  ### User Index
  
  get "up" => "rails/health#show", as: :rails_health_check


end
