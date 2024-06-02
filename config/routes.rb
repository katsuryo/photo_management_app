Rails.application.routes.draw do
  root 'sessions#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :photos, only: %i[index new create]
  # OAuthコールバック
  get 'oauth/callback', to: 'oauth#callback'
end
