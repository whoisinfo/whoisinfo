Rails.application.routes.draw do
  constraints name: /(?!:\/\/)([a-zA-Z0-9]+\.)?[a-zA-Z0-9][a-zA-Z0-9-]+\.[a-zA-Z]{2,9}?/ do
    get '/:name' => 'domains#show'
  end

  namespace :api, :defaults => {:format => 'json'}  do
    namespace :v1 do
      constraints name: /(?!:\/\/)([a-zA-Z0-9]+\.)?[a-zA-Z0-9][a-zA-Z0-9-]+\.[a-zA-Z]{2,9}?/ do
        get 'domains/:name' => 'domains#show'
        resources :domains, only: :create
      end
    end
  end
end
