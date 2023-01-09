class TagsController < ApplicationController
  include TagsMethods
  
  def index
    tags = Tag.all.select(:id, :name)
    tag_count = Booktag.all.group(:tag_id).count
    @tags = []
    tags.each_with_index do |tag, i|
      tag = tag.attributes
      tag["count"] = tag_count[tag["id"]]
      @tags << tag
    end
    if @tags.length > 1
      @tags = tags.sort{ |a,b| b["count"] <=> a["count"]}
    end
  end
  
  def show
    book_tags = Booktag.all
    relationship_records = book_tags.select{ |ph| ph.tag_id == params[:id].to_i}.map(&:book_id)
    all_books = Book.all
    @books = all_books.select{ |book| relationship_records.include?(book.id)}
    @book_objects = creating_structures(books: @books, book_tags: book_tags, tags: Tag.all)
  end
end
