Rails.application.routes.draw do

  resources :calls
  resources :recordings
  resources :callers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
end
