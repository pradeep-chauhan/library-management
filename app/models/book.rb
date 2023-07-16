class Book < ApplicationRecord
  belongs_to :library
  belongs_to :user, optional: true

  validates :title, presence: true, uniqueness: true
end
