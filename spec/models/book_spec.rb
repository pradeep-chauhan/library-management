require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it 'is valid with a title, available status, library, and optional user' do
      library = Library.create(name: 'Main Library')
      book = Book.new(title: 'Book Title', available: true, library: library)
      expect(book).to be_valid
    end

    it 'is invalid without a title' do
      library = Library.create(name: 'Main Library')
      book = Book.new(title: nil, library: library)
      expect(book).to_not be_valid
    end

    it 'is invalid without a library' do
      book = Book.new(title: 'Book Title', available: true, library: nil)
      expect(book).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a library' do
      book = Book.reflect_on_association(:library)
      expect(book.macro).to eq(:belongs_to)
    end

    it 'belongs to an optional user' do
      book = Book.reflect_on_association(:user)
      expect(book.macro).to eq(:belongs_to)
      expect(book.options[:optional]).to eq(true)
    end
  end
end