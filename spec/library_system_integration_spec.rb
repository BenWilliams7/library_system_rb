
require "capybara/rspec"
require "./app"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new book', {:type => :feature}) do
  it('allows a user to click a book list to add a book to the library') do
    visit('/')
    visit('/books')
    visit('/book/add')

    fill_in('title', :with =>'The Hobbit')
    fill_in('authors', :with =>'Tolkien')

    click_button('Add Book')
    expect(page).to have_content('Book List')
  end
end

describe('adding a new patron', {:type => :feature}) do
  it('allows a user to click a book list to add a book to the library') do
    visit('/')
    visit('/patron_list')
    visit('/patron/add')

    fill_in('name', :with =>'Fred')

    click_button('Add Patron')
    expect(page).to have_content('Patron List')
  end
end

describe('seeing patron details', {:type => :feature}) do
  it('allows a user to click a book list to add a book to the library') do
    visit('/')
    visit('/patron_list')
    visit('/patron/add')

    fill_in('name', :with =>'Fred')

    click_button('Add Patron')
    click_link('Fred')
    expect(page).to have_content('Patron: Fred')
  end
end

describe('seeing book details', {:type => :feature}) do
  it('allows a user to click a book list to add a book to the library') do
    visit('/')
    visit('/books')
    visit('/book/add')

    fill_in('title', :with =>'The Hobbit')
    fill_in('authors', :with =>'Tolkien')

    click_button('Add Book')
    click_link('The Hobbit')
    expect(page).to have_content('Book Title: The Hobbit')
  end
end
