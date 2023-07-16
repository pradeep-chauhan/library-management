require 'rails_helper'

RSpec.describe Library, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      library = Library.new(name: 'Main Library')
      expect(library).to be_valid
    end

    it 'is invalid without a name' do
      library = Library.new(name: nil)
      expect(library).to_not be_valid
    end
  end

  describe 'associations' do
    it 'has many books' do
      library = Library.reflect_on_association(:books)
      expect(library.macro).to eq(:has_many)
    end
  end
end