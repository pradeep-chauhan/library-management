class Book < ApplicationRecord
  belongs_to :library
  belongs_to :user, optional: true
end
