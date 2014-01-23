require 'rest_client'

module CustomerScoreAPI
  def self.uri(customer)
    uri = URI('http://internal.leapfrogonline.com/customer_scoring')
    params = {
      income: customer.income,
      zipcode: customer.zipcode,
      age: customer.age
    }
    uri.query = URI.encode_www_form(params)
    uri
  end

  def self.score(customer)
    url = "http://internal.leapfrogonline.com/customer_scoring"
    resp = RestClient.get(url, {:params => 
                            { income: customer.income,
                              zipcode: customer.zipcode,
                              age: customer.age
                            } } )
    JSON.parse(resp.body)
  end


end
