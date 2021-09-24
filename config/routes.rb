Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#index'
  post 'pages/feed_update', to: 'pages#feed_update', as: 'feed_update'
  get '/crck_fetch', to: 'pages#crck_fetch', as: 'crck_fetch'
  get 'srivarthan/feeds', to: 'pages#feeds'
  get '/crack_show',to: 'orders#crack_show', as: 'crack_show'
  get '/order', to: "pages#order", as: 'order'
  post '/order_update', to: 'orders#order_update', as:'order_update'
  get 'order_show', to: 'pages#order_show', as: 'order_show'
  # get '/crack_show', to: 'order'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
