Rails.application.routes.draw do

devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_scope :customer do
  post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
end

  namespace :admin do
    resources :spots do
      resources :reviews
    end
    resources :customers, only: [:index, :show, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    get "search" => "spots#search"
  end
  

scope module: :public do
    root 'homes#top'
    resources :spots do
    resources :reviews
  end
    get "search" => "spots#search"
    resources :customers, only: [:index, :show, :create, :edit, :update]
end

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
