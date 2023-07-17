require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "GET /libraries/:id/books/:id" do
    let!(:library) { Library.create(name: "Main Library") }
    let!(:book1) { Book.create(title: "Book 1", available: true, library: library) }
    let!(:book2) { Book.create(title: "Book 2", available: false, library: library, user: User.create(email: "test_user@gmail.com", password: "12345678")) }
   
    it "returns information about books" do
      get "/libraries/#{library.id}/books/#{book1.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(book1.title)
    end

    it "returns information about books with user details" do
      get "/libraries/#{library.id}/books/#{book2.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(book2.user.email)
    end
  end
end