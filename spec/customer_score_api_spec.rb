require 'minitest/spec'
require 'minitest/autorun'
require 'webmock/minitest'
require 'leapFrogAPI/customer_score_api'
require 'json'

describe CustomerScoreAPI do
  before do
    @api_url = "http://internal.leapfrogonline.com/customer_scoring"
    @api = CustomerScoreAPI.new(@api_url)
  end

  it "score customers through the external API" do
    income = 5000
    zipcode = 60201
    age = 35
    score = {"propensity" => 0.26532, "ranking" => "C" }

    stub_request(:get, @api_url).
      with({:query => {:income => income, :zipcode => zipcode, :age => age }}).
      to_return({:body => score.to_json,
                  :headers => {"content_type" => "application/json" } } )
    
    c = Customer.new(income, zipcode, age)
    assert_equal(score, @api.score(c))
  end
  
  it "should pass along any RestClient errors that are raised " do
    income = 100
    zipcode = 60606
    age = 19

    stub_request(:any, @api_url).
      with({:query => {:income => income, :zipcode => zipcode, :age => age }}).
      to_return(:status => [500, "Internal Server Error"])
    c = Customer.new(income, zipcode, age)
    assert_raises(RestClient::InternalServerError) { @api.score(c) }
  end
end
  
