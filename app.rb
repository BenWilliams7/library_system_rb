require 'sinatra'
require 'sinatra/reloader'
require './lib/book'
require './lib/author'
require './lib/patron'
require 'pry'

also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end

get('/patron_list') do
  erb(:patron_list)
end

get('/book_list') do
  erb(:book_list)
end
