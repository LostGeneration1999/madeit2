Rails.application.routes.draw do

  devise_for :users , controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'users/:id/edit' => 'users/registrations#edit'
  end

  resources :users, only: [:edit, :show] do
    collection do
      post ':id/follow' => 'users#follow' , as: 'follow'
      post ':id/unfollow' => 'users#unfollow', as: 'unfollow'
    end
  end
  resources :products do
    collection do
      get :ranking
      get 'search/:tags' => 'products#search_tag' , as: 'search_ids'
      post 'search/:tags' => 'products#search_tag' , as: 'search_id'
      get :search
      post :search
      get :top
    end
    resources :comments, only: [:destroy, :create]
    resources :likes, only: [:create, :destroy]
  end
  root 'products#top'
end
