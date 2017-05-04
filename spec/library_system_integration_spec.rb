
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

# describe('viewing all of the lists', {:type => :feature}) do
#   it('allows a user to see all of the lists that have been created') do
#     list = List.new({:name => 'Epicodus Homework', :id => nil})
#     list.save()
#     visit('/')
#     click_link('View All Lists')
#     expect(page).to have_content(list.name)
#   end
# end
#
# describe('seeing details for a single list', {:type => :feature}) do
#   it('allows a user to click a list to see the tasks and details for it') do
#     test_list = List.new({:name => 'School stuff', :id => nil})
#     test_list.save
#     test_task = Task.new({:description => "learn SQL", :due_date => '2017-05-03 00:00:00', :list_id => test_list.id})
#     test_task.save
#     visit('/lists')
#     click_link(test_list.name)
#     expect(page).to have_content(test_task.description)
#   end
#
#   describe('adding tasks to a list', {:type => :feature}) do
#     it('allows a user to add a task to a list') do
#       test_list = List.new({:name => 'School stuff', :id => nil})
#       test_list.save
#       visit("/lists/#{test_list.id}")
#       fill_in("description", {:with => "Learn SQL"})
#       fill_in("due_date", {:with => "2017-05-03 00:00:00"})
#       click_button("Add task")
#       expect(page).to have_content("Success")
#     end
#   end
