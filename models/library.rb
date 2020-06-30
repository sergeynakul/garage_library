# frozen_string_literal: true

class Library
  include Validation

  DATA_FILE = 'db/data.yml'

  def initialize
    @authors = []
    @books = []
    @readers = []
    @orders = []
  end

  def add_authors(author)
    validate_type(author, author, Author)
    @authors << author
  end

  def add_books(book)
    validate_type(book, book, Book)
    @books << book
  end

  def add_readers(reader)
    validate_type(reader, reader, Reader)
    @readers << reader
  end

  def add_orders(order)
    validate_type(order, order, Order)
    @orders << order
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

  def fetch_author_by(index)
    data = YAML.load_file(DATA_FILE)
    data.authors[index]
  end

  def fetch_book_by(index)
    data = YAML.load_file(DATA_FILE)
    data.books[index]
  end

  def fetch_reader_by(index)
    data = YAML.load_file(DATA_FILE)
    data.readers[index]
  end

  def top_readers(quantity)
    most_popular(quantity, :reader)
  end

  def top_books(quantity)
    most_popular(quantity, :book)
  end

  def number_readers_of_top_books(quantity)
    popular_books = top_books(quantity)
    @orders.select { |order| popular_books.include? order.book }.map(&:reader).uniq.length
  end

  protected

  attr_reader :authors, :books, :readers, :orders

  private

  def most_popular(quantity, entity)
    @orders.group_by(&entity).max_by(quantity) { |_, value| value.length }.map(&:first)
  end
end
