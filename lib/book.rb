class Book
  attr_reader(:title, :authors, :checkout, :due_date, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @authors = attributes.fetch(:authors)
    @checkout = attributes.fetch(:checkout)
    @due_date = attributes.fetch(:due_date)
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
      id = book.fetch('id').to_i
      books.push(Book.new({:title => title, :authors => authors, :checkout => checkout, :due_date => due_date, :id => id}))
    end
    books
  end

 def  save
    #  @@all_books.push(self)
   result = DB.exec("INSERT INTO book (title, authors, checkout, due_date) VALUES ('#{@title}', '#{@authors}','#{@checkout}','#{@due_date}')  RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def ==(another_book)
    self.title.==(another_book.title).&(self.id.==(another_book.id))
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

  define_method(:delete) do
    DB.exec("DELETE FROM book_patron WHERE book_id = #{self.id()};")
    DB.exec("DELETE FROM book WHERE id = #{self.id()};")
  end

  def Book.title_search(query)
    found_books = DB.exec("SELECT * FROM book WHERE title LIKE '#{query}%';")
    books = []
    found_books.each() do |book|
      title = book.fetch('title')
      authors = book.fetch('authors')
      checkout = book.fetch('checkout')
      due_date = book.fetch('due_date')
      id = book.fetch('id').to_i
      books.push(Book.new({:title => title, :authors => authors, :checkout => checkout, :due_date => due_date, :id => id}))
    end
    books
  end

  def Book.author_search(query)
    found_books = DB.exec("SELECT * FROM book WHERE authors LIKE '#{query}%';")
    books = []
    found_books.each() do |book|
      title = book.fetch('title')
      authors = book.fetch('authors')
      checkout = book.fetch('checkout')
      due_date = book.fetch('due_date')
      id = book.fetch('id').to_i
      books.push(Book.new({:title => title, :authors => authors, :checkout => checkout, :due_date => due_date, :id => id}))
    end
    books
  end

end
