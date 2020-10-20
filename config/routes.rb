Rails.application.routes.draw do
  root 'static_pages#index'

  get '/auth/:provider/callback', to: 'sessions#create', as: :signin
  delete '/logout', to: 'sessions#destroy', as: :logout
end
