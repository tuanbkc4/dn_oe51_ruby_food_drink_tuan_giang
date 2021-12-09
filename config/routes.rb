Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_page#index"
    get "/index", to: "home_page#index"
  end
end
