Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_page#index"
    get "/index", to: "home_page#index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    
    resources :addresses
    resources :orders do
      put :cancel, on: :member
    end
    resources :products, only: %i(index show)
    resources :carts, only: %i(index destroy) do
      collection do
        post "/add_item_to_cart/:id", to: "carts#create", as: "add_item_to"
        put "/update_cart/:id", to: "carts#update_cart", as: "update_item"
        put "/update_rating/:id", to: "carts#update_rating_item", as: "update_rating_item"
      end
    end
    resources :users, only: %i(show)
    
    namespace :admin do
      root "static_page#home"
      get "/home", to: "static_page#home"
      delete "/logout", to: "static_page#destroy"
      resources :categories, except: %i(show)
      resources :products, except: %i(show)
    end
  end
end
