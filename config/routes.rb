Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: %i[index create destroy]

  get '/auth/:provider/callback', to: 'sessions#create', as: :signin
  delete '/logout', to: 'sessions#destroy', as: :logout
end
