# frozen_string_literal: true

class Reader
  include Validation

  attr_reader :name

  validate %i[name email city street house], :presence
  validate %i[name email city street], :type, String
  validate :house, :type, Integer
  validate :house, :positive

  def initialize(args = {})
    @name = args[:name]
    @email = args[:email]
    @city = args[:city]
    @street = args[:street]
    @house = args[:house]
    validate!
  end
end
