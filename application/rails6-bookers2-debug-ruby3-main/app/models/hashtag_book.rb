class HashtagBook < ApplicationRecord
  belongs_to :book
  belongs_to :hashtag
  validates :book_id, presence: true
  validates :hashtag_id, presence: true
end
