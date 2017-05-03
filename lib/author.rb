class Author
  attr_reader(:name, :books, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @books = attributes.fetch(:books)
    @id = attributes.fetch(:id)
  end

  def Author.all
   # @@all_authors
    returned_authors = DB.exec("SELECT * FROM author;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch('name')
      books = author.fetch('books')
      id = author.fetch('id').to_i
      authors.push(Author.new({:name => name, :books => books, :id => id}))
    end
    authors
  end

  def save
   #  @@all_authors.push(self)
   result = DB.exec("INSERT INTO author (name, books) VALUES ('#{@name}', '#{@books}') RETURNING id;")
   @id = result.first.fetch('id').to_i
  end

  def ==(another_author)
    self.name.==(another_author.name).&(self.id.==(another_author.id))
  end

  define_singleton_method(:find) do |id|
    found_author = nil
    Author.all.each do |author|
      if author.id.==(id)
        found_author = author
      end
    end
    found_author
  end
end
