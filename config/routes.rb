Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :invitations, only: [] do
    collection do
      post :share
    end
  end

  get 'watch_youtube_video', to: "home#watch_youtube_video"
  post 'update_youtube_stream_count', to: "home#update_youtube_stream_count"
  get 'my_points', to: "home#my_points"
  get 'quest', to: "home#quest"
  post 'add_post_link', to: "home#add_post_link"
  get 'download/:filename', to: 'home#download', as: 'download_image'
  get 'profile', to: "home#profile"

  devise_for :users, controllers: { sessions: 'home' }
  resources :home do
    collection do
      get 'dashboard'
      post 'edit_profile', to: 'home#update_profile'
    end
  end
end
