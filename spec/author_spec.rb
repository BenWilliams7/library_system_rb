require "rspec"
require "pg"
require "pry"
require "spec_helper"

describe(Author) do
  describe ".all" do
    it('is empty at first') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe "#save" do
    it("adds a author to the array of saved authors") do
      test_author = Author.new({:name => "Tolkien", :books => "The Hobbit", :book_id => 1})
      test_author.save()
      expect(Author.all()).to(eq([test_author]))
    end
  end

  describe "#name" do
    it("lets you give it a name") do
      test_author = Author.new({:name => "Tolkien", :books => "The Hobbit", :book_id => 1})
      expect(test_author.name()).to(eq("Tolkien"))
    end
  end

  describe "author_id" do
    it("lets you read the author ID out") do
      test_author = Author.new({:name => "Tolkien", :books => "The Hobbit", :book_id => 1})
      expect(test_author.book_id).to(eq(1))
    end
  end

  describe '#==' do
    it 'is the same author if it has the same description and list ID' do
      author1 = Author.new({:name => "Tolkien", :books => "The Hobbit", :book_id => 1})
      author2 = Author.new({:name => "Tolkien", :books => "Tolkien", :book_id => 1})
      expect(author1).to(eq(author2))
    end
  end
end
