Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "boards#index"
  resources :boards do
    member do
      post :reveal_cell
    end
  end
end
