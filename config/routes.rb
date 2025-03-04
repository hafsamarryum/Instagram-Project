Rails.application.routes.draw do
  root "posts#index"

  devise_for :users,
    path: "",
    path_names: { sign_in: "Login", sign_out: "Logout", edit: "profile", sign_up: "registration" },
    controllers: { registrations: "registrations" }

  # Users routes
  resources :users, only: [ :index, :show ]  do
    member do
      post :follow
      post :unfollow
    end
  end


  # Posts routes
  resources :posts, only: [ :index, :show, :create, :destroy ] do
    member do
      patch :archive
      patch :unarchive
    end
    collection do
      get :archived
    end
    resources :likes, only: [ :create, :destroy ], shallow: true
    resources :comments, only: [ :create, :destroy ], shallow: true
    resources :bookmarks, only: [ :create, :destroy ], shallow: true
  end
end
