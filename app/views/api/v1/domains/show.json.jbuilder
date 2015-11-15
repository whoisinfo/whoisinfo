json.cache! ['api', 'v1', @domain] do
  json.extract! @domain, :name, :expires_on, :status
end
