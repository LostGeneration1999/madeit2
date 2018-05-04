Rails.application.routes.draw do

  devise_for :users , controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'users/:id/edit' => 'users/registrations#edit'
  end

  resources :users, only: [:edit, :show]
  resources :products do
    collection do
      get :search
      get :top
    end
    resources :comments, only: [:destroy, :create]
    resources :likes, only: [:create, :destroy]
  end
  root 'products#top'
end
