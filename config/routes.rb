Personalizedress::Application.routes.draw do
  resources :dresses
  resources :users
  # map '/' to be a redirect to '/dresses'
  root :to => redirect('/dresses')
  get '/search', to:"dresses#search"
  get '/signup', to:"users#signup", as: :signup_users
  get '/signin', to:"users#signin", as: :signin_users
end
