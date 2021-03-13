Rails.application.routes.draw do

  # devise_for :products
  

   



    resources :produto
    root 'produto#index'
    get 'produto/index'
    get 'produto/show'
    get 'produto/new'
    get 'produto/create'
    get 'produto/edit'
    get 'produto/update'
    get 'produto/destroy'


    # mount API::Base => '/api/v1/products'
    # mount API::Base, at: "/"
    # mount API::Base => '/'
    mount ApplicationApi => "/"
    # mount Base => "/api"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
