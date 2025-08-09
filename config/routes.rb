Rails.application.routes.draw do
  # === Root Route ===
  root "quotes#index"
  
  # === Main Routes ===
  resources :quotes, only: [:index, :show, :new, :create] do
    member do
      patch :vote              # PATCH /quotes/:id/vote
      patch :increment_views   # PATCH /quotes/:id/increment_views
    end
    
    collection do
      get :random     # GET /quotes/random
      get :jokes      # GET /quotes/jokes  
      get :inspiring  # GET /quotes/inspiring
    end
    
    # Nested comments
    resources :comments, only: [:create, :destroy]
  end
  
  # === User Registration ===
  resources :users, only: [:new, :create]
  
  # === API Routes (for AJAX calls) ===
  namespace :api do
    namespace :v1 do
      resources :quotes, only: [:index, :show] do
        member do
          post :vote
          post :increment_views
        end
        resources :comments, only: [:index, :create]
      end
    end
  end
  
  # === Health Check ===
  get "up" => "rails/health#show", as: :rails_health_check

  # === PWA Routes ===
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest  
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
