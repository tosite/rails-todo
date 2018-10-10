Rails.application.routes.draw do
  get '/' => redirect('/tasks')
  get    'tasks'          => 'tasks#index'
  post   'tasks'          => 'tasks#store'
  put    'tasks/:id'      => 'tasks#update'
  put    'tasks/:id/done' => 'tasks#done'
  get    'tasks/:id'      => 'tasks#show'
  delete 'tasks/:id'      => 'tasks#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
