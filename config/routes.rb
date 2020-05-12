Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "homepages#index"
  
  resources :drivers 
  resources :passengers do
    resources :trips, only: [:create]
  end

  resources :trips, only: [:show, :destroy, :edit, :update]

  patch '/drivers/:id/available', to: 'drivers#availability', as: 'available_driver'
end
