Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :token, only: [:create]
      resources :users, only: [:show] do
        resources :dogs, only:[:show]
      end
    end
  end
end
