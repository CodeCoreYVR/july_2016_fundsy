Rails.application.routes.draw do
  resources :campaigns, only: [:new, :create, :show, :index, :destroy] do
    resources :pledges, only: [:create, :destroy]
    resources :publishings, only: [:create]
  end
  root "campaigns#index"
end
