# frozen_string_literal: true

class Seed
  def initialize(library)
    @library = library
  end

  def generate_data
    seed_authors
    seed_books
    seed_readers
    seed_orders
  end

  def seed_authors
    10.times do
      @library.add_authors(Author.new(Faker::Book.unique.author, Faker::Lorem.sentence(word_count: 10)))
    end
  end

  def seed_books
    50.times do
      @library.add_books(Book.new(Faker::Book.unique.title, @library.fetch_author_by_index(rand(0..9))))
    end
  end

  def seed_readers
    20.times do
      @library.add_readers(Reader.new(name: Faker::Name.unique.name,
                                      email: Faker::Internet.unique.email,
                                      city: Faker::Address.city,
                                      street: Faker::Address.street_name,
                                      house: Faker::Address.building_number.to_i))
    end
  end

  def seed_orders
    100.times do
      @library.add_orders(Order.new(book: @library.fetch_book_by_index(rand(0..49)),
                                    reader: @library.fetch_reader_by_index(rand(0..19)),
                                    date: Date.today - rand(0..30)))
    end
  end
end
