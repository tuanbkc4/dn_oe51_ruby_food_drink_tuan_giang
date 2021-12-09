Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home_page#home"
    get "/home", to: "home_page#home"
  end
end
