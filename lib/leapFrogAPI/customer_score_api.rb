require 'rest_client'
require 'json'

class CustomerScoreAPI
  def initialize(url)
    @url = url
  end

  # get a score for a given customer object 
  def score(customer)
    resp = RestClient.get(@url, {:params => 
                            { income: customer.income,
                              zipcode: customer.zipcode,
                              age: customer.age
                            } } )
    JSON.parse(resp.body)
  end

end
