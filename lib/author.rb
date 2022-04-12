# frozen_string_literal: true

class Author
  attr_reader :name

  def initialize(id, name, letter)
    @id = id
    @name = name
    @letter = letter
  end
end
