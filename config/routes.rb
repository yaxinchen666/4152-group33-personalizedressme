Personalizedress::Application.routes.draw do
  resources :dresses
  # map '/' to be a redirect to '/dresses'
  root :to => redirect('/dresses')
  get '/search', to:"dresses#search"
end
