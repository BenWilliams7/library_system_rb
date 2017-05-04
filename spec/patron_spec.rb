require "rspec"
require "pg"
require "pry"
require "spec_helper"

describe(Patron) do
  describe ".all" do
    it('is empty at first') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe "#save" do
    it("adds a patron to database of saved patrons") do
      test_patron = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :id => 1})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  describe "#name" do
    it("lets you give it a name") do
      test_patron = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :id => 1})
      expect(test_patron.name()).to(eq("Fred"))
    end
  end

  describe "#id" do
    it("lets you read the book ID out") do
      test_patron = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :id => 1})
      expect(test_patron.id).to(eq(1))
    end
  end

  describe '#==' do
    it 'is the same patron if it has the same description and list ID' do
      patron1 = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :id => 1})
      patron2 = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :id => 1})
      expect(patron1).to(eq(patron2))
    end
  end


  describe(".find") do
    it('returns patron by id') do
      patron1 = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :id => 1})
      patron1.save()
      patron2 = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :id => 1})
      patron2.save()
      expect(Patron.find(patron1.id)).to(eq(patron1))
    end
  end

  describe("#update") do
    it("lets you add a book to a patron") do
      test_patron = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :id => nil})
      test_patron.save()
      book1 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => nil})
      book1.save
      book2 = Book.new({:title => "Les Miserables", :authors => "Victor Hugo", :checkout => false, :due_date => "2017-05-10", :id => nil})
      book2.save
      test_patron.update({:book_ids => [book1.id, book2.id]})
      expect(test_patron.books).to(eq([book1, book2]))
    end
  end

  describe("#books") do
    it("returns all of the books checked out by a particular patron") do
      test_patron = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "It", :due_date => "2017-05-10", :id => 1})
      test_patron.save()
      book1 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :id => 2})
      book1.save
      book2 = Book.new({:title => "Les Miserables", :authors => "Victor Hugo", :checkout => false, :due_date => "2017-05-10", :id => 3})
      book2.save
      test_patron.update({:book_ids => [book1.id, book2.id]})
      expect(test_patron.books).to(eq([book1, book2]))
    end
  end
end
