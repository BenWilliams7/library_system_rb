class Patron
  attr_reader(:name, :book_history, :current_books, :due_date, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @book_history = attributes.fetch(:book_history)
    @current_books = attributes.fetch(:current_books)
    @due_date = attributes.fetch(:due_date)
    @id = attributes.fetch(:id)
  end

  def Patron.all
   # @@all_patrons
    returned_patrons = DB.exec("SELECT * FROM patron;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch('name')
      book_history = patron.fetch('book_history')
      current_books = patron.fetch('current_books')
      due_date = patron.fetch('due_date')
      id = patron.fetch('id').to_i
      patrons.push(Patron.new({:name => name, :book_history => book_history, :current_books => current_books, :due_date => due_date, :id => id}))
    end
    patrons
  end

  def save
   #  @@all_patrons.push(self)
   result = DB.exec("INSERT INTO patron (name, book_history, current_books, due_date) VALUES ('#{@name}', '#{@book_history}','#{@current_books}','#{@due_date}') RETURNING id;")
   @id = result.first.fetch('id').to_i
  end

  def ==(another_patron)
    self.name.==(another_patron.name).&(self.id.==(another_patron.id))
  end

  define_singleton_method(:find) do |id|
    found_patron = nil
    Patron.all.each do |patron|
      if patron.id.==(id)
        found_patron = patron
      end
    end
    found_patron
  end

  define_method(:delete) do
    DB.exec("DELETE FROM book_patron WHERE patron_id = #{self.id()};")
    DB.exec("DELETE FROM patron WHERE id = #{self.id()};")
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE patron SET name = '#{@name}' WHERE id = #{self.id};")

    attributes.fetch(:book_ids, []).each do |book_id|
      DB.exec("INSERT INTO book_patron (book_id, patron_id) VALUES (#{book_id}, #{self.id});")
    end
  end

  define_method(:books) do
    patron_books = []
    results = DB.exec("SELECT book_id FROM book_patron WHERE patron_id = #{self.id()};")
    results.each() do |result|
      book_id = result["book_id"].to_i
      book = DB.exec("SELECT * FROM book WHERE id = #{book_id};")
      id = book[0]['id'].to_i
      title = book[0]["title"]
      authors = book[0]['authors']
      checkout = book[0]['checkout']
      due_date = book[0]['due_date']
      patron_books.push(Book.new({:title => title, :authors => authors, :checkout => checkout, :due_date => due_date, :id => id}))
      # binding.pry
    end
    patron_books
  end

  def return_book(attributes)
    attributes.fetch(:book_ids, []).each do |book_id|
      DB.exec("ALTER TABLE book_patron DROP VALUES (#{book_id}, #{self.id}) WHERE id = #{self.id};")
    end
  end
end
