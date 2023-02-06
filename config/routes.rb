Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations' }
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get 'privacy', to: 'static_public#privacy'
  get 'terms', to: 'static_public#terms'
  get 'pricing', to: 'static_public#pricing'
  # post "checkout/create", to: "checkout#create", as: "checkout_create"
  get "checkout/create", to: "checkout#create", as: "checkout_create"
  get "billing_portal/create", to: "billing_portal#create", as: "billing_portal_create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_public#landing_page"
  
  resources :webhooks, only: [:create]

  resources :posts do
    member do
      get "upvote", to: "posts#upvote"
      get "downvote", to: "posts#downvote"
    end
  end
  resources :users, only: %i[index show]
end