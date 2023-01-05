class BookCommentsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.create(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_back(fallback_location: root_path) } 
        format.js 
      else
        format.html { redirect_back(fallback_location: root_path) } 
      end
    end
  end
  
  #comment = current_user.book_comments.new(book_comment_params)
    #comment.book_id = book.id
    #comment.save
    #redirect_to book_path(book)
  
  def destroy
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.find_by(params[:book_comment_id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end


  private
  
  def comment_params
    params.require(:book_comment).permit(:comment).merge(user_id: current_user.id, book_id: params[:book_id])
  end
  
end