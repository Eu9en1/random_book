# frozen_string_literal: true

class PublishingHouse
  attr_reader :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end
