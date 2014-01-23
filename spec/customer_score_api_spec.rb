require 'minitest/spec'
require 'minitest/autorun'
require 'webmock/minitest'

require 'leapFrogAPI/customer_score_api'
require 'json'

describe CustomerScoreAPI do
  describe "foo" do
    it "should turn build a URI for a given customer" do
      c = Customer.new(50000, 60201, 35)
      uri = "http://internal.leapfrogonline.com/customer_scoring?income=50000&zipcode=60201&age=35"
      assert_equal(CustomerScoreAPI.uri(c).to_s, uri.to_s)
    end
    
    it "should foo" do
      income = 5000
      zipcode = 60201
      age = 35
      score = {"propensity" => 0.26532, "ranking" => "C" }

      stub_request(:get, "http://internal.leapfrogonline.com/customer_scoring").
        with({:query => {:income => income, :zipcode => zipcode, :age => age }}).
        to_return({:body => score.to_json,
                   :headers => {"content_type" => "application/json" } } )

      c = Customer.new(income, zipcode, age)
      assert_equal(score, CustomerScoreAPI.score(c))
      
    end
  end
end
  
#       @m = Minitest::Mock.new
#       request = "http://internal.leapfrogonline.com/customer_scoring?income=50000&zipcode=60201&age=
# 35"
#       resp = {:propensity => 0.26532, :ranking => "C" }.to_json
#       @m.expect(:access, resp, [request])
#       assert_equal(@m.access(request), "5")

