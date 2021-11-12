Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "home#index"
  get "/changepassword" => "users#changepassword", as: :changepassword_user
  get "/manageusers" => "users#manage_users", as: :manage_users

  resources :users, :orders, :order_items, :menu_categories, :menu_items

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
