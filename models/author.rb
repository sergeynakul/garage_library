# frozen_string_literal: true

class Author
  include Validation

  attr_reader :name, :biography

  validate :name, :presence
  validate :name, :type, String

  def initialize(name, biography = '')
    @name = name
    @biography = biography
    validate!
  end
end
