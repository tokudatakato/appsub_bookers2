module TagMethods
    extend ActiveSupport::Concern
    
    def extract_tag(body)
      if body.blank?
        return
      end
      return body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    end
    
    def save_tag(tag_array,book_instance)
      if tag_array.blank?
        return
      end
      
      tag_array.uniq.map do |tag|
        tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
        
        book_tag = BookTag.new
        book_tag.book_id = book_instance.id
        book_tag.tag_id = tag
        book_tag.save
      end
    end
     
    def creating_structures(books: "", book_tags: "", tags: "")
      array = []
      books.each do |book|
        tag = []
        book_hash = book.attributes
        related_tag_records = book_tags.select{|ph| ph.book_id == book.id }
        related_tag_records.each do |record|
          tag << tags.detect{ |tah| tag.id == record.tag_id }
        end
        book_hash["tags"] = tag
        array << book_hash
      end
      return array
    end
    
    def delete_records_related_to_tag(book_id)
      relationship_records = Booktag.where(book_id: book.id)
      if relationship_records.present?
        relationship_records.each do |record|
          record.destroy
        end
      end
      all_tags = Tag.all
      all_related_records = Booktag.all
      all_tags.each do |tag|
        if all_related_records.nane?{ |record| tag.id == record.tag_id }
          tag.destroy
        end
      end
    end
  end
    
    