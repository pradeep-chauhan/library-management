require 'rails_helper'

RSpec.describe "Libraries", type: :request do
  describe "GET /libraries/:id" do
    let!(:library) { Library.create(name: "Main Library") }
    let!(:book1) { Book.create(title: "Book 1", available: true, library: library) }
    let!(:book2) { Book.create(title: "Book 2", available: false, library: library, user: User.create(email: "test_user@gmail.com", password: "12345678")) }

    it "returns information about all libraries" do
      get "/libraries"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(book1.title)
    end

    it "returns information about books in a specific library" do
      get "/libraries/#{library.id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(book1.title)
      expect(response.body).to include(book2.title)
    end
  end
end