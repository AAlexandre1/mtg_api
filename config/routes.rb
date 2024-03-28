Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :players do
    resources :libraries
    resources :wishlists
    resources :decks do
      resources :deck_cards
    end
  end

  resources :cards do
    resources :mana_costs
  end
  
  resources :manas
  resources :types
  
  post '/players/:player_id/decks/:deck_id/add_card', to: 'decks#add_card'

  

end
