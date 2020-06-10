# frozen_string_literal: true

class Order
  attr_reader :book, :reader

  def initialize(book, reader, date = Date.today)
    @book = book
    @reader = reader
    @date = date
  end
end
