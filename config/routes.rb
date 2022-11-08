Rails.application.routes.draw do
  # get 'categories/index'
  # get 'categories/show'
  # get 'categories/edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'
  # get 'users', to: 'users#index'
  resources :users, param: :username do 
    resources :categories
  end

end
