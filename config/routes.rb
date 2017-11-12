Rails.application.routes.draw do
  namespace :api do
    namespace :v1  do
      post 'user_token' => 'user_token#create'

      resources :products
    end
  end

  root   'static_pages#home'

  get    '/login',            to: 'sessions#new'
  post   '/login',            to: 'sessions#create'
  get    '/logout',           to: 'sessions#destroy'

  get    '/calendar',         to: 'calendars#index'

  get    '/activity_imports', to: redirect('activity_imports/new')
  get    '/purchase_imports', to: redirect('purchase_imports/new')
  resources :activity_imports, only: [:new, :create]
  resources :purchase_imports, only: [:new, :create]

  resources :products
end
