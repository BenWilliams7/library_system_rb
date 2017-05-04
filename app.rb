require 'sinatra'
require 'sinatra/reloader'
require './lib/book'
require './lib/author'
require './lib/patron'
require 'pg'
require 'pry'

also_reload('lib/**/*.rb')
DB = PG.connect({:dbname => 'library_system'})

get('/') do
  erb(:index)
end

get('/patron_list') do
  @patrons = Patron.all
  erb(:patron_list)
end


get('/patron/add') do
  erb(:patron_form)
end

post('/patrons') do
  name = params.fetch('name')
  book_history = ""
  current_books = ""
  due_date = '2100-05-05'
  book_id = 0
  id = nil
  @patron = Patron.new({:name => name, :book_history => book_history, :current_books => current_books, :due_date => due_date, :book_id => book_id, :id => id})
  @patron.save
  @patrons = Patron.all
  erb(:patron_list)
end

get('/patrons/:id') do
  @books = Book.all
  @patron = Patron.find(params.fetch('id').to_i)
  erb(:patron_details)
end

patch('/patrons/:id') do
  patron_id = params.fetch("id").to_i
  @patron = Patron.find(patron_id)
  book_ids = (params.fetch("book_ids")).map{|book_id| book_id.to_i}
  @patron.update({:book_ids => book_ids})
  book = (params.fetch("book_ids")).map{|book_id| book_id.to_i}
  book_ids.each do |id|
    book = Book.find(id)
  end
  book.update({:checkout => "yes"})
  @book = book
  @books = Book.all
# binding.pry
  erb(:patron_details)
end

get('/patrons/:id/return_book') do
  @books = Book.all
# binding.pry
  @patron = Patron.find(params.fetch('id').to_i)
  erb(:patron_details)
end

patch('/patrons/:id/return_book') do
  book_id = params.fetch('id').to_i
binding.pry
  @patron = Patron.find(params.fetch('id').to_i)
  @patron.return_book(:book_ids => book_id)
  book = Book.find(book_id)
  book.update({:checkout => "no"})
  @book = book
  @books = Book.all
  erb(:patron_details)
end

get('/book_list') do
  @books = Book.all
  erb(:book_list)
end

get('/book/add') do
  erb(:book_form)
end

post('/books') do
  title = params.fetch('title')
  authors = params.fetch('authors')
  checkout = "no"
  due_date = '2017-05-15'
  author_id = 0
  patron_id = 0
  id = nil
  @book = Book.new({:title => title, :authors => authors, :checkout => checkout, :due_date => due_date, :author_id => author_id, :patron_id => patron_id, :id => id})
  @book.save
  @books = Book.all
  erb(:book_list)
end

get('/books/:id') do
  @book = Book.find(params.fetch('id').to_i)
  erb(:book_details)
end

delete("/books/:id") do
  @book = Book.find(params.fetch('id').to_i)
  @book.delete
  @books = Book.all
  erb(:book_list)
end

get('/title_book_search') do
  search_title = params.fetch('search_title')
  @books = Book.title_search(params.fetch("search_title"))
  erb(:title_search_results)
end

get('/author_book_search') do
  search_author = params.fetch('search_author')
  @books = Book.author_search(params.fetch("search_author"))
  erb(:author_search_results)
end
