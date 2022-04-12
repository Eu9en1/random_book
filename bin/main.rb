# frozen_string_literal: true

require 'tty-prompt'
require_relative '..\lib\book'
require_relative '..\lib\reader'
require_relative '..\lib\books_store'

def main
  @prompt = TTY::Prompt.new
  menu_item = ['Случайная книга', 'Выход']
  books_store = Reader.read

  puts books_store.information_book_store.to_s

  loop do
    choice = @prompt.enum_select('Выберите пункт из меню', menu_item)
    case choice
    when 'Случайная книга'
      puts "\nИнформация о книге:\n#{books_store.information_random_book}"
    when 'Выход'
      puts '> Работа завершина'
      break
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
