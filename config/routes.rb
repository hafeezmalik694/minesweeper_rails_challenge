Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "boards#index"
  resources :boards do
    member do
      patch :reveal_cell
      patch :add_flag
    end
  end
end
