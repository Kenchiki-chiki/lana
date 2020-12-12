Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :channels, only: %i[create show] do
    resources :messages, only: %i(create)
  end
end
