Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  
  
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:new, :create,]
  
  resources :tasks, only: [:index, :new, :show, :create, :edit, :destroy]
end
