# frozen_string_literal: true

require_relative 'book'
require_relative 'category'
require_relative 'author'
require_relative 'publishing_house'

class BooksStore
  def initialize(books = {}, authors = {}, categories = {},
                 publishing_houses = {})
    @books = books
    @authors = authors
    @categories = categories
    @publishing_houses = publishing_houses
  end

  def add_books(books)
    books.each do |book|
      @books[book['id']] =
        Book.new(book['id'], book['attributes'], book['relationships'])
    end
  end

  def add_categories(categories)
    categories.each do |category|
      @categories[category['id']] =
        Category.new(category['id'], category['categoryName'])
    end
  end

  def add_authors(authors)
    authors.each do |author|
      @authors[author['id']] =
        Author.new(author['id'], author['authorName'], author['letter'])
    end
  end

  def add_publishing_houses(publishing_houses)
    publishing_houses.each do |publishing_house|
      @publishing_houses[publishing_house['id']] =
        PublishingHouse.new(publishing_house['id'],
                            publishing_house['publishingHouse'])
    end
  end

  def information_book_store
    "\n\tИнформация о книжном магазине:\n" \
      "\tОбщее количество книг: #{count_books}\n" \
      "\tКоличество книг, свободных для предзаказа: #{free_books}\n" \
      "\tПопулярные издания: #{popular_publishing_house[:number_one]} - " \
      "#{popular_publishing_house[:number_one_size]}; " \
      "#{popular_publishing_house[:number_two]} - " \
      "#{popular_publishing_house[:number_two_size]}\n\n"
  end

  def count_books
    @books.size
  end

  def free_books
    @books.select do |_id, book|
      book.attributes['lastReleaseDate'].nil?
    end.size
  end

  def popular_publishing_house
    publishing_house = Hash.new(0)

    @books.each_pair do |_id, book|
      publishing_house_id = book.relationships['publishingHouse']
      publishing_house[publishing_house_id] += 1
    end

    pop = publishing_house.to_a.sort_by { |_k, v| v }
    size = pop.size
    {
      number_one: @publishing_houses[pop[size - 1][0]].name,
      number_one_size: pop[size - 1][1],
      number_two: @publishing_houses[pop[size - 2][0]].name,
      number_two_size: pop[size - 2][1]
    }
  end

  def information_random_book
    random_book = @books.values.sample

    category = @categories[random_book.relationships['category']].name
    name_book = random_book.attributes['name']

    if random_book.relationships['authors'].size.zero?
      author = 'Без автора'
    else
      author = ''
      authors_id = random_book.relationships['authors']
      authors_id.each do |hash_id|
        author += "#{@authors[hash_id['id']].name}; "
      end
    end

    amount_total = random_book.attributes['amountTotal']
    isbn = random_book.attributes['isbn']

    "Категория: #{category}\n" \
      "Название книги: #{name_book}; Автор(ы): #{author}\n" \
      "Стоимость книги #{amount_total}\n" \
      "ISBN: #{isbn}"
  end
end
