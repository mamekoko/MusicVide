Rails.application.routes.draw do

  devise_for :users

  scope module: 'public' do
    root "homes#top"

    resources :post_images, only: [:new, :create, :index, :show, :destroy] do
      resources :post_comments, only: [:create]
    end
    resources :users, only: [:show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
