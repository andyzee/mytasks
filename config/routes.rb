Rails.application.routes.draw do
  # resources :projects, only: [:index] do
  #   resources :todos, only: [:update]
  # end
  
  # resources :todos, only: [:create]
  # root "articles#index"
  get '/projects', to: 'projects#index'
  post '/projects', to: 'projects#create'
  post '/todos', to: 'todos#create'
  patch '/projects/:project_id/todos/:id', to: 'todos#update'
end
