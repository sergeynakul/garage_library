# frozen_string_literal: true

require 'faker'
require 'time'
require_relative './db/seed'
require_relative './moduls/validation'
require_relative './models/library'
require_relative './models/author'
require_relative './models/book'
require_relative './models/reader'
require_relative './models/order'
require_relative './errors/presence_error'
require_relative './errors/type_class_error'
require_relative './errors/number_value_error'

library = Library.new
seed = Seed.new(library)
seed.generate_data
library.store_data
library.load_data

puts 'Your choice:'
puts '1. Display top readers'
puts '2. Display most popular books'
puts '3. Display number of readers of the most popular books'

choice = gets.chomp.to_i

def quantity(default_value)
  input = gets.chomp
  input.empty? ? default_value : input.to_i
end

case choice
when 1
  puts 'Indicate the quantity of returned top readers (default 1)'
  puts library.top_readers(quantity(1)).map(&:name)
when 2
  puts 'Indicate the quantity of returned most popular books (default 1)'
  puts library.top_books(quantity(1)).map(&:title)
when 3
  puts 'Indicate the quantity of the most popular books (default 3)'
  puts library.number_readers_of_top_books(quantity(3))
end
