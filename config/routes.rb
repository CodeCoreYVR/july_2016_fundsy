Rails.application.routes.draw do
  resources :campaigns, only: [:new, :create, :show, :index, :destroy] do
    resources :pledges, only: [:create, :destroy]
    resources :publishings, only: [:create]
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  
  root "campaigns#index"
end
