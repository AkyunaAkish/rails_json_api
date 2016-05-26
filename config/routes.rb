Rails.application.routes.draw do

  post '/signup' => 'auth#signup'
  post '/signin' => 'auth#signin'

  get '/todos' => 'todos#index'
  post '/todos' => 'todos#create'

end
