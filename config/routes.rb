Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }  
  resources :posts do  
    get '/users/sign_out' => 'devise/sessions#destroy'
    resources :comments
    end  
  root 'posts#index'  
end


