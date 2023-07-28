Rails.application.routes.draw do

  devise_for :admin_users, controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users

  namespace :admin do
    get 'sign_in', to: 'sessions#new'
    resources :users, only: [:index, :show] do
      member do
        patch :toggle_suspended
      end
    end
  end

  scope module: 'public' do
    root "homes#top"

    resources :post_images, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
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
