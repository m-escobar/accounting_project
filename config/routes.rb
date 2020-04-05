Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get  '/balance', to: 'accounts#show'
      post '/account', to: 'accounts#create'
      post '/transfer', to: 'accounts#transfer'
    end
  end
end
