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

get('/book_list') do
  erb(:book_list)
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
  # @patrons = Patron.all
  @patron = Patron.find(params.fetch('id').to_i)
# binding.pry
  erb(:patron_details)
end
