# frozen_string_literal: true

class Reader
  attr_reader :name

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end
end
