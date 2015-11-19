Rails.application.routes.draw do
  constraints name: /(?!:\/\/)([a-zA-Z0-9]+\.)?[a-zA-Z0-9][a-zA-Z0-9-]+\.[a-zA-Z]{2,9}?/ do
    get '/:name' => 'domains#show'
  end

  namespace :api, :defaults => {:format => 'json'}  do
    constraints name: /(?!:\/\/)([a-zA-Z0-9]+\.)?[a-zA-Z0-9][a-zA-Z0-9-]+\.[a-zA-Z]{2,9}?/ do
      get '/:name' => 'domains#show'
    end
  end
end
