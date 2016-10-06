Rails.application.routes.draw do
  resources :campaigns, shallow: true, only: [:new, :create, :show, :index, :destroy] do
    resources :pledges, only: [:create, :destroy] do
      resources :payments, only: [:new, :create]
    end
    resources :publishings, only: [:create]
  end

  # resources :pledge, only: [] do
  #   resources :payments, only: [:new, :create]
  # end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root "campaigns#index"
end
