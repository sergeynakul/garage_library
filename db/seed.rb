# frozen_string_literal: true

class Seed
  class << self
    def generate_data(library)
      seed_authors(library)
      seed_books(library)
      seed_readers(library)
      seed_orders(library)
    end

    def seed_authors(library)
      10.times do
        library.authors << Author.new(Faker::Book.unique.author, Faker::Lorem.sentence(word_count: 10))
      end
    end

    def seed_books(library)
      library.authors.each do |author|
        rand(5..20).times do
          library.books << Book.new(Faker::Book.unique.title, author)
        end
      end
    end

    def seed_readers(library)
      20.times do
        library.readers << Reader.new(name: Faker::Name.unique.name,
                                      email: Faker::Internet.unique.email,
                                      city: Faker::Address.city,
                                      street: Faker::Address.street_name,
                                      house: Faker::Address.building_number.to_i)
      end
    end

    def seed_orders(library)
      100.times do
        library.orders << Order.new(book: library.books.sample,
                                    reader: library.readers.sample,
                                    date: Date.today - rand(0..30))
      end
    end
  end
end
