class Customer
  attr_reader :income, :zipcode, :age
  def initialize(income, zipcode, age)
    @income = income
    @zipcode = zipcode
    @age = age
  end
end
