require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many books' do
      user = User.reflect_on_association(:books)
      expect(user.macro).to eq(:has_many)
    end
  end
end