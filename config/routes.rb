# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :users, only: [:create]
  resource :authentication, only: [:nil], path: 'auth' do
    post :login
  end
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
