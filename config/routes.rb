Rails.application.routes.draw do

  

  devise_for :users

  namespace :admin do
    resources :users, only: [:index, :show, :update, :destroy]
  end

  scope module: 'public' do
    root "homes#top"

    resources :post_images, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :likes, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      member do
        get :likes
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
