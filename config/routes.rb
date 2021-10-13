Rails.application.routes.draw do
  resources :posts
  get 'main', to: 'main#loginpage', as: 'login_page'
  post 'main', to: 'main#checklogin'

  get 'register', to: 'main#registerpage', as: 'register_page'
  post 'register', to: 'main#registration'

  get 'feed', to: 'account#feedpage', as: 'feed_page'
  get 'profile/:name', to: 'account#profilepage', as: 'profile_page'

  get 'post/create', to: 'account#createpostpage', as: 'create_post_page'

  post 'logout', to: 'account#logout', as: 'logout'

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
