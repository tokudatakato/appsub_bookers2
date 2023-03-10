Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'homes#top'
  get "home/about"=>"homes#about"
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update, :new] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'follower' => 'relationships#follower'
    get 'followed' => 'relationships#followed'
  end
  get "search" => "searches#search"
  get '/book/hashtag/:name' => 'books#hashtag'
  get '/book/hashtag' => 'books#hashtag'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
