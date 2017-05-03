class Patron
  attr_reader(:name, :book_history, :current_books, :due_date, :book_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @book_history = attributes.fetch(:book_history)
    @current_books = attributes.fetch(:current_books)
    @due_date = attributes.fetch(:due_date)
    @book_id = attributes.fetch(:book_id)
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
      book_id = patron.fetch('book_id').to_i
      patrons.push(Patron.new({:name => name, :book_history => book_history, :current_books => current_books, :due_date => due_date, :book_id  => book_id}))
    end
    patrons
  end

  def save
   #  @@all_patrons.push(self)
   DB.exec("INSERT INTO patron (name, book_history, current_books, due_date, book_id) VALUES ('#{@name}', '#{@book_history}','#{@current_books}','#{@due_date}', #{@book_id});")
  end

  def ==(another_patron)
    self.name.==(another_patron.name).&(self.book_id.==(another_patron.book_id))
  end
end
