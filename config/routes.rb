Rails.application.routes.draw do
  resources :dreams
  root "static_pages#home"

  get "about", to: "static_pages#about"
end
