Rails.application.routes.draw do
  #Root
  root 'static_views#home'

  #Home route
  get 'static_views/home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
