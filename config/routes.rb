Rails.application.routes.draw do
  root "posts#index"
  devise_for :users,
  path: "",
  path_names: { sign_in: "Login", sign_out: "Logout", edit: "profile", sign_up: "registration" },
  controllers: { registrations: "registrations" }


  resources :users, only: [ :index, :show ]

  resources :posts, only: [ :index, :show, :create, :destroy ] do
    resources :likes, only: [ :create, :destroy ], shallow: true
    resources :comments, only: [ :create, :destroy ], shallow: true
    resources :bookmarks, only: [ :create, :destroy ], shallow: true
  end
end
