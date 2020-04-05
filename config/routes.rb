Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get  '/balance', to: 'accounts#show'
  post '/customer', to: 'accounts#create'
  post '/transfer', to: 'accounts#transfer'
end
