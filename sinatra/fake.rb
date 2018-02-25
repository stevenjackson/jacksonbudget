require 'sinatra'
require 'json'

set :bind, '0.0.0.0'

mime_type :json, "application/json"
get '/dashboard' do
  content_type  "application/json"
  id_token = request.env["HTTP_X_AUTH_TOKEN"]

  {
    balances: [
      {
        category: "bread",
        budget: 100,
        balance: 17
      }
    ]
  }.to_json
end
