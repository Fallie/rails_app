Rails.application.routes.draw do
  resources :appointments
  
  get 'users/new'

  #Root
  root 'static_views#home'

  #Home route
  get '/home', to: 'static_views#home'

  #User route
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
