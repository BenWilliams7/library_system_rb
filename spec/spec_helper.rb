require 'rspec'
require 'pg'
require 'book'
require 'patron'
require 'author'

DB = PG.connect({:dbname => "library_system_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM book *;")
    DB.exec("DELETE FROM patron *;")
    DB.exec("DELETE FROM author *;")
    DB.exec("DELETE FROM book_patron *;")
  end
end
