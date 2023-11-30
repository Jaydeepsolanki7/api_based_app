Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root "users#index"
  resources :users do
    collection do
      get "gem_searching", to:"users#gem_searching"
    end
  end
  # get '/admins', to: 'users#admins', as: "admins"
  # get '/normal_user', to: 'users#normal_user', as: "normal_user" 
  post "users/search", to: "users#search"
end
