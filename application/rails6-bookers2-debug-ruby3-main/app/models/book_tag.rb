class BookTag < ApplicationRecord
  validates :book_id, presence: true
  validates :tag_id, presence: true
end
