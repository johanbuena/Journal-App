Rails.application.routes.draw do
  root 'journals#index'

  devise_for :users

  resources :journals do
    resources :tasks
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
