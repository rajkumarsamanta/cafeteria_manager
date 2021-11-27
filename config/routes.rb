Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "home#index"
  get "/changepassword" => "users#changepassword", as: :changepassword_user
  get "/manageusers" => "users#manage_users", as: :manage_users
  get "/users/:id/email" => "users#email", as: :email_user
  get "/users/:id/role" => "users#role", as: :role_user
  get "/users/:id/change_password" => "users#change_password", as: :change_password

  get "menu_categories/:id/add_item" => "menu_categories#add_item", as: :add_item
  get "menu_items/:id/flip_status" => "menu_items#flip_status", as: :flip_status

  get "cart_items/:id/plus" => "cart_items#plus", as: :plus
  get "cart_items/:id/minus" => "cart_items#minus", as: :minus

  get "orders/:id/edit" => "orders#edit", as: :edit

  #get "/updatemenus" => "menu_categories#update_menus", as: :update_menus
  get "/managemenus" => "menu_categories#manage_menus", as: :manage_menus

  resources :users, :orders, :order_items, :menu_categories, :menu_items
  resources :carts, :cart_items

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
