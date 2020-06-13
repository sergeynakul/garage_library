# frozen_string_literal: true

class Book
  include Validation

  attr_reader :title

  validate :title,  :presence
  validate :title,  :type, String
  validate :author, :type, Author

  def initialize(title, author)
    @title = title
    @author = author
    validate!
  end
end
