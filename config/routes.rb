Rails.application.routes.draw do
  # get 'sessions/new'

  get       '/'       => 'sessions#new'
  get       'signup'  => 'users#new'
  get       '/login'  => 'sessions#new'
  post      '/login'  => 'sessions#create'
  delete    '/logout' => 'sessions#destroy'
  resources :users, :only => [:index, :show, :new, :create, :update]

  resources :tasks, :only => [:index, :show, :create, :update, :destroy]
  # get '/' => redirect('/users')
  # get    'tasks'          => 'tasks#index'
  # post   'tasks'          => 'tasks#store'
  # put    'tasks/:id'      => 'tasks#update'
  # put    'tasks/:id/done' => 'tasks#done'
  # get    'tasks/:id'      => 'tasks#show'
  # delete 'tasks/:id'      => 'tasks#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
