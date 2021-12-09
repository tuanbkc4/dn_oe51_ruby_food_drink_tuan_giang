Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_page#index"
    get "/index", to: "home_page#index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    
    resources :products, only: %i(index show)
    
    namespace :admin do
      root "static_page#home"
      get "/home", to: "static_page#home"
      resources :categories, except: %i(show)
    end
  end
end
