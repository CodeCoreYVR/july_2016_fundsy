Rails.application.routes.draw do
  resources :campaigns, only: [:new, :create, :show, :index, :destroy] do
    resources :pledges, only: [:create, :destroy]
  end
  root "campaigns#index"
end
