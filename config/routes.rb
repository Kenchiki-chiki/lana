Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => 'users/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :users, only: %i[index]

  resources :channels, only: %i[create show] do
    resources :messages, only: %i(create)
    resources :participations, only: %i(create)
  end
end
