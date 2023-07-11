Rails.application.routes.draw do
  
  devise_for :users
  
  scope module: 'public' do
    root "homes#top"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
