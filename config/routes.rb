Rails.application.routes.draw do
  # devise_for :users path_names: { sign_in: 'login', sign_out: 'logout', registration: 'register', sign_up: 'cmon_let_me_in' }
  devise_for :users
  resources :users do
    resources :posts
  end

  resources :posts, only: [:new, :create, :index]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # root to: 'home#index'
  root "posts#index"
end
