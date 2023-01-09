class Hashtag < ApplicationRecord
  validates :hashname, presence: true, length: {macimum: 50}
  has_many :hashtag_books, dependent: :destroy
  has_many :books, through: :hashtag_books
end
