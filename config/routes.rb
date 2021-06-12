Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions"}
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions"}
  # get 'home/index'
  root 'home#index'
  resources :bookings
  resources :customers
  resources :suppliers
  resources :cars

  get :about, to: "home#about"
  get :contact, to: "home#contact"
  get :term, to: "home#term"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
