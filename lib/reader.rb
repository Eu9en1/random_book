# frozen_string_literal: true

require 'json'
require_relative 'books_store'
require_relative 'book'

module Reader
  def self.read
    file_books = File.expand_path('..\data\books.json', __dir__)
    books_store = BooksStore.new
    ruby_objects = JSON.parse(File.read(file_books))

    books_store.add_books(ruby_objects['books'])
    books_store.add_categories(ruby_objects['categories'])
    books_store.add_authors(ruby_objects['internalAuthors'])
    books_store.add_publishing_houses(ruby_objects['publishingHouses'])

    books_store
  end
end
