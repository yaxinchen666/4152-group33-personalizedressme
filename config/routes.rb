Personalizedress::Application.routes.draw do
  resources :dresses
  resources :users
  # map '/' to be a redirect to '/dresses'
  root :to => redirect('/dresses')
  get '/search', to:"dresses#search"
  get '/signup', to:"users#signup", as: :signup_users
  post '/signup', to:"users#create", as: :post_signup_users
  get '/signin', to:"users#signin", as: :signin_users
  post '/signin', to:"users#post_signin", as: :post_signin_users
  get '/profile', to:"users#profile", as: :profile_users
  post '/logout', to:"users#logout", as: :post_logout_users
end
