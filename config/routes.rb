Rails.application.routes.draw do

  devise_for :users , controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'users/:id/edit' => 'users/registrations#edit'
  end

resources :likes, only: [:create, :destroy]

  resources :users, only: [:edit, :show]
  resources :products do
    collection do
      get :top
    end
    resources :comments, only: [:destroy, :create]
  end
  root 'products#top'
end
