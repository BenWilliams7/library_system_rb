class Book
  attr_reader(:title, :authors, :checkout, :due_date, :author_id, :patron_id, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @authors = attributes.fetch(:authors)
    @checkout = attributes.fetch(:checkout)
    @due_date = attributes.fetch(:due_date)
    @author_id = attributes.fetch(:author_id)
    @patron_id = attributes.fetch(:patron_id)
    @id = attributes.fetch(:id)
  end

  def Book.all
   # @@all_books
   returned_books = DB.exec("SELECT * FROM book;")
   books = []
   returned_books.each() do |book|
     title = book.fetch('title')
     authors = book.fetch('authors')
     checkout = book.fetch('checkout')
     due_date = book.fetch('due_date')
     author_id = book.fetch('author_id').to_i
     patron_id = book.fetch('patron_id').to_i
     id = book.fetch('id').to_i
     books.push(Book.new({:title => title, :authors => authors, :checkout => checkout, :due_date => due_date, :author_id => author_id, :patron_id => patron_id, :id => id}))
   end
   books
 end

 def save
   #  @@all_books.push(self)
  result = DB.exec("INSERT INTO book (title, authors, checkout, due_date, author_id, patron_id) VALUES ('#{@title}', '#{@authors}','#{@checkout}','#{@due_date}', #{@author_id}, #{@patron_id}) RETURNING id;")
   @id = result.first.fetch('id').to_i
 end

 # define_singleton_method(:clear) do
 #   @@all_books = []
 # end

 def ==(another_book)
   self.title.==(another_book.title).&(self.patron_id.==(another_book.patron_id))
 end

 define_singleton_method(:find) do |id|
   found_book = nil
   Book.all.each do |book|
     if book.id.==(id)
       found_book = book
     end
   end
   found_book
 end

end
