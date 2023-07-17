class Book < ApplicationRecord
  belongs_to :library
  belongs_to :user, optional: true

  validates :title, presence: true, uniqueness: true

  def checkout(user_id)
    if self.available?
      errors.add(:available, 'This book is not available for checkout')
    else
      user = User.find_by_id(user_id)
      self.update!(user: user)
    end
  end
end
