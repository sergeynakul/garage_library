# frozen_string_literal: true

class Reader
  include Validation

  attr_reader :name, :email, :city, :street, :house

  validate %i[name email city street house], :presence
  validate %i[name email city street], :type, String
  validate :house, :type, Integer
  validate :house, :more_than, 0

  def initialize(args = {})
    @name = args[:name]
    @email = args[:email]
    @city = args[:city]
    @street = args[:street]
    @house = args[:house]
    validate!
  end
end
