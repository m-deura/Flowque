Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "pages#top"

  namespace :mypage do
    root to: "menu#show"
    resource :quick_memo, only: %i[show edit update destroy]
    resources :techniques
    resources :charts, only: %i[show edit update] do
      resources :nodes, shallow: true
    end
    resource :setting, only: %i[show edit update]
  end


  namespace :api do
    namespace :v1 do
      resources :charts, only: %i[index show]
    end
  end
end
