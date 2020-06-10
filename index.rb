# frozen_string_literal: true

require_relative './models/library.rb'

library = Library.new
library.generate_data
library.store_data
library.load_data

puts 'Your choice:'
puts '1. Display top readers'
puts '2. Display most popular books'
puts '3. Display number of readers of the most popular books'

choice = gets.chomp.to_i

def quantity
  input = gets.chomp
  input.empty? ? 1 : input.to_i
end

case choice
when 1
  puts 'Indicate the quantity of returned top readers (default 1)'
  puts library.top_readers(quantity).map(&:name)
when 2
  puts 'Indicate the quantity of returned most popular books (default 1)'
  puts library.top_books(quantity).map(&:title)
when 3
  puts 'Number of readers of the most popular books:'
  puts library.number_readers_of_top_books
end
