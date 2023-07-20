Rails.application.routes.draw do

  devise_for :users

  scope module: 'public' do
    root "homes#top"

    resources :post_images, only: [:new, :create, :index, :show, :destroy] do
      resource :likes, only: [:create, :destroy]
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
