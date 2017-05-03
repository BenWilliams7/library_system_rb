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
      test_patron = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :book_id => 1})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  describe "#name" do
    it("lets you give it a name") do
      test_patron = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :book_id => 1})
      expect(test_patron.name()).to(eq("Fred"))
    end
  end

  describe "book_id" do
    it("lets you read the book ID out") do
      test_patron = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :book_id => 1})
      expect(test_patron.book_id).to(eq(1))
    end
  end

  describe '#==' do
    it 'is the same patron if it has the same description and list ID' do
      patron1 = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :book_id => 1})
      patron2 = Patron.new({:name => "Fred", :book_history => "Don Quixote", :current_books => "The Hobbit", :due_date => "2017-05-10", :book_id => 1})
      expect(patron1).to(eq(patron2))
    end
  end
end
