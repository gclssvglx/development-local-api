require "sinatra"
require "json"

before do
  content_type :json
end

get "/find-local-council/query.json" do
  return invalid_postcode_response if postcode_invalid(params["postcode"])

  return postcode_not_found_response unless postcode_found(params["postcode"])

  response_filename = postcode_to_response[params["postcode"]]

  status 200
  body File.read("response/#{response_filename}.json")
end

get "/find-local-council/:slug" do
  status 200
  body File.read("response/#{params["slug"]}")
end

def postcode_not_found_response
  status 404
  body "{\"message\":\"Postcode not found\"}"
end

def invalid_postcode_response
  status 404
  body "{\"message\":\"Invalid postcode\"}"
end

def postcode_invalid(postcode)
  /^([A-Z][A-HJ-Y]?\d[A-Z\d]? ?\d[A-Z]{2}|GIR ?0A{2})$/.match(postcode.gsub("%20", " ").gsub("+", " ")).nil?
end

def postcode_found(postcode)
  postcode_to_response.keys.include?(postcode)
end

def postcode_to_response
  {
    "E18QS" => "tower-hamlets",
    "DE451QW" => "derbyshire-dales",
    "BH228UB" => "addresses"
  }
end
