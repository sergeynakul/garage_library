# frozen_string_literal: true

class Book
  attr_reader :title

  def initialize(title, author)
    @title = title
    @author = author
  end
end
