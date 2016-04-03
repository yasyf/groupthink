require 'sidekiq/web'

Rails.application.routes.draw do
  root 'list#index'
  get 'list/:username/:name' => 'list#view'
  get 'list/:username/:name/status' => 'list#status'
  mount Sidekiq::Web => '/sidekiq'
end
