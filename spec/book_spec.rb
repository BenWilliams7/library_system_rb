require "spec_helper"
require "rspec"
require "pg"
require "pry"

describe(Book) do
  describe ".all" do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe "#save" do
    it("adds a book to the array of saved books") do
      test_book = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :author_id => 1, :patron_id => 1, :id => 1})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe "#title" do
    it("lets you give it a title") do
      test_book = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :author_id => 1, :patron_id => 1, :id => 1})
      expect(test_book.title()).to(eq("The Hobbit"))
    end
  end

  describe "author_id" do
    it("lets you read the author ID out") do
      test_book = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :author_id => 1, :patron_id => 1, :id => 1})
      expect(test_book.author_id).to(eq(1))
    end
  end

  describe '#==' do
    it 'is the same book if it has the same description and list ID' do
      book1 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :author_id => 1, :patron_id => 1, :id => 1})
      book2 = Book.new({:title => "The Hobbit", :authors => "Tolkien", :checkout => false, :due_date => "2017-05-10", :author_id => 1, :patron_id => 1, :id => 1})
      expect(book1).to(eq(book2))
    end
  end
end
