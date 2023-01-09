class CreateHashtagBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtag_books do |t|
      t.references :book, foreign_key: true
      t.references :hashtag, foreign_key: true
    end
  end
end
