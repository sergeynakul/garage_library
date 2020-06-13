# frozen_string_literal: true

module Seed
  def generate_data
    seed_authors
    seed_books
    seed_readers
    seed_orders
  end

  def seed_authors
    10.times do
      @authors << Author.new(Faker::Book.unique.author, Faker::Lorem.sentence(word_count: 10))
    end
  end

  def seed_books
    @authors.each do |author|
      rand(5..20).times do
        @books << Book.new(Faker::Book.unique.title, author)
      end
    end
  end

  def seed_readers
    20.times do
      @readers << Reader.new(name: Faker::Name.unique.name,
                             email: Faker::Internet.unique.email,
                             city: Faker::Address.city,
                             street: Faker::Address.street_name,
                             house: Faker::Address.building_number.to_i)
    end
  end

  def seed_orders
    100.times do
      @orders << Order.new(book: @books.sample, reader: @readers.sample, date: Date.today - rand(0..30))
    end
  end
end
