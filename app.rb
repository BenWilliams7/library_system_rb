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
  checkout = false
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
  # @books = Book.all
  @book = Book.find(params.fetch('id').to_i)
  erb(:book_details)
end
