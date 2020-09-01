# frozen_string_literal: true

class Order
  include Validation

  attr_reader :book, :reader, :date

  validate :book,   :type, Book
  validate :reader, :type, Reader
  validate :date,   :type, Date

  def initialize(args = {})
    @book = args[:book]
    @reader = args[:reader]
    @date = args[:date] || Date.today
    validate!
  end
end
