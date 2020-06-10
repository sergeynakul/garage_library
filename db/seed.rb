# frozen_string_literal: true

require 'faker'
require_relative '../models/author.rb'
require_relative '../models/book.rb'
require_relative '../models/reader.rb'
require_relative '../models/order.rb'

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
      @readers << Reader.new(Faker::Name.unique.name,
                             Faker::Internet.unique.email,
                             Faker::Address.city,
                             Faker::Address.street_name,
                             Faker::Address.building_number)
    end
  end

  def seed_orders
    100.times do
      @orders << Order.new(@books.sample, @readers.sample, Date.today - rand(0..30))
    end
  end
end
