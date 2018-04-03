Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, format: :json do
    namespace :v1 do
      resources :info, only: [:show] do
        resources :reviews, only: [:index]
      end
    end
  end

  root to: "home#index"
end
