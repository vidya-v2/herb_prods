Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :charges
  get 'thanks', to: 'charges#thanks', as: 'thanks'
end
