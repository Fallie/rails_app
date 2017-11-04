Rails.application.routes.draw do
  get 'users/new'

  #Root
  root 'static_views#home'

  #Home route
  get '/home', to: 'static_views#home'

  #User route
  resources :users, controller: 'users', only: 'create'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
