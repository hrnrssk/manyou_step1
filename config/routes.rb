Rails.application.routes.draw do
  get 'tasks/index'
  get 'tasks/show'
  resources :tasks
end
