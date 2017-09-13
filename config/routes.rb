Rails.application.routes.draw do

  resources :pages, only: [:index]
  match '/css', to: redirect('/css/bootstrap.min.css'), via: [:get]

  resources :users, only: [:index, :create, :show, :update, :destroy]

  resources :analytics, only: [:index, :create, :show, :update, :destroy]

  root :to => "pages#index"
end
