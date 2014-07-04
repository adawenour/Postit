PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destory'




  resources :posts, except: [:destroy] do
  	resources :comments, only: [:create]
  end
  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:show, :create, :edit, :update]
end

#POST /votes => 'VotesController#create'

# POST /posts/3/vote => 'PostsController#vote'
# POST /comments/4/vote => 'CommentsController#vote'

