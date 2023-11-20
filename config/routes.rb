# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"
  resources :dreams

  get "about", to: "static_pages#about"
end
