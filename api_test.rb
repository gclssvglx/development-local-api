require "minitest/autorun"
require "faraday"
require "json"

class APITest < Minitest::Test
  def test_simple_response
    skip("Issues with ruby HTTP clients (Faraday and RestClient) not following redirects")

    response = Faraday.get(
      "http://localhost:4567/find-local-council/query.json?postcode=E18QS",
      { "Content-Type" => "application/json" }
    )

    assert_equal 200, response.status
    assert_equal File.read("response/tower-hamlets.json"), response.body
  end

  def test_two_tier_response
    skip("Issues with ruby HTTP clients (Faraday and RestClient) not following redirects")

    response = Faraday.get(
      "http://localhost:4567/find-local-council/query.json?postcode=DE451QW",
      { "Content-Type" => "application/json" }
    )

    assert_equal 200, response.status
    assert_equal File.read("response/derbyshire-dales.json"), response.body
  end

  def test_ambiguous_postcode_response
    skip("Issues with ruby HTTP clients (Faraday and RestClient) not following redirects")

    response = Faraday.get(
      "http://localhost:4567/find-local-council/query.json?postcode=BH228UB",
      { "Content-Type" => "application/json" }
    )

    assert_equal 200, response.status
    assert_equal File.read("response/addresses.json"), response.body
  end

  def test_post_ambiguous_postcode_response_dorset
    response = Faraday.get(
      "http://localhost:4567/find-local-council/dorset.json",
      { "Content-Type" => "application/json" }
    )

    assert_equal 200, response.status
    assert_equal File.read("response/dorset.json"), response.body
  end

  def test_post_ambiguous_postcode_response_bcp
    response = Faraday.get(
      "http://localhost:4567/find-local-council/bournemouth-christchurch-poole.json",
      { "Content-Type" => "application/json" }
    )

    assert_equal 200, response.status
    assert_equal File.read("response/bournemouth-christchurch-poole.json"), response.body
  end

  def test_invalid_postcode
    response = Faraday.get(
      "http://localhost:4567/find-local-council/query.json?postcode=SW1",
      { "Content-Type" => "application/json" }
    )

    assert_equal 400, response.status
    assert_equal "{\"message\":\"Invalid postcode\"}", response.body
  end

  def test_postcode_not_found
    response = Faraday.get(
      "http://localhost:4567/find-local-council/query.json?postcode=SW1A1AA",
      { "Content-Type" => "application/json" }
    )

    assert_equal 404, response.status
    assert_equal "{\"message\":\"Postcode not found\"}", response.body
  end

  def test_rate_limit
    response = Faraday.get(
      "http://localhost:4567/find-local-council/query.json?postcode=SW1A2AB",
      { "Content-Type" => "application/json" }
    )

    assert_equal 429, response.status
    assert_equal "{\"message\":\"Too many requests\"}", response.body
  end
end
