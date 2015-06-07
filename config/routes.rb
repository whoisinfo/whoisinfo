Rails.application.routes.draw do
  namespace :api, :defaults => {:format => 'json'}  do
    namespace :v1 do
      constraints name: /[0-z\.]+/ do
        get 'domains/:name' => 'domains#show'
        resources :domains, only: :create
      end
    end
  end
end
