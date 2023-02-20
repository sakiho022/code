

Rails.application.routes.draw do
  get 'gender/top'
  get 'about' =>'about#top'
  get 'keywords/db'
  post 'keywords/db' =>'keywords#db'
  get 'keywords/index'
  get 'login' =>"keywords#login_form"

  post "login" => "keywords#login"
  get '/'=> 'home#top'
  post '/'=> 'home#top'
  post "logout" => "keywords#logout"
  post 'home/check' => 'home#check'
  post 'keywords/create_index' => 'keywords#create_index'
  post 'keywords/destroy_index' => 'keywords#destroy_index'
  post 'keywords/create_show' => 'keywords#create_show'
  post 'keywords/destroy_show' => 'keywords#destroy_show'
  get 'keywords/show' => 'keywords#show'
  get 'keywords/index' => 'keywords#index'
  get 'keywords/data'
  post 'keywords/data' => 'keywords#data'

  get 'about/how'


end

