# frozen_string_literal: true

class Library
  include Seed

  BOOK_QUANTITY = 3
  DATA_FILE = 'db/data.yml'

  attr_accessor :authors, :books, :readers, :orders

  def initialize
    @authors = []
    @books = []
    @readers = []
    @orders = []
  end

  def store_data
    File.open(DATA_FILE, 'w') { |file| file.write(to_yaml) }
  end

  def load_data
    data = YAML.load_file(DATA_FILE)
    @authors = data.authors
    @books = data.books
    @readers = data.readers
    @orders = data.orders
  end

  def top_readers(quantity)
    most_popular(quantity, :reader)
  end

  def top_books(quantity)
    most_popular(quantity, :book)
  end

  def number_readers_of_top_books
    @orders.select { |order| top_books(BOOK_QUANTITY).include? order.book }.map(&:reader).uniq.length
  end

  private

  def most_popular(quantity, entity)
    @orders.group_by(&entity).max_by(quantity) { |_, value| value.length }.to_h.keys
  end
end
