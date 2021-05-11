Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users,  controllers: { sessions: "users/sessions", registrations: "users/registrations" }
 
  root "products#index"
  resources :products
  resources :shipping_details
  get "/cards/:shipping_details_id", to: "cards#index", as: :select_card
  resources :cards
  get "/user_items", to: "products#view_user_items", as: :view_user_items
  get "/categories/:category", to: "products#category", as: :category
  get "/cart", to: "carts#view", as: :view_cart
  get "/cart/clear", to: "carts#clear", as: :clear_cart
  post "/cart/:id", to: "cart_items#add", as: :cart
  put "/cart_item/increment/:id", to: "cart_items#increment", as: :increment
  put "/cart_item/decrement/:id", to: "cart_items#decrement", as: :decrement
  delete "/cart_item/destroy/:id", to: "cart_items#destroy", as: :destroy_cart_item
  post "/order", to: "orders#create", as: :create_order
  get "/orders", to: "orders#index", as: :orders
  get "/orders/:id", to: "orders#show", as: :view_order
  get "/ordered_items/:id", to: "ordered_items#show", as: :view_ordered_item
  get "*path", to: "products#index"
end
