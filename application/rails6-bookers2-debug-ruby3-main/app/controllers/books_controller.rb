class BooksController < ApplicationController
  include TagMethods
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end
  
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = User.find(@book.user_id)
    @comment = BookComment.new
    @comments = @book.book_comments.all
    related_records = BookTag.where(book_id: @book.id).pluck(:tag_id)
    tags = Tag.all
    @tags = tags.select{|tag| related_records.include?(tag.id)}
    @display_body = @book.body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/,"")
  end

  def index
    @books = Book.all
    @book = Book.new
    @tags = Tag.all
    @book_tags = BookTag.all
    @book_objects = creating_structures(books: @books,book_tags: @book_tags,tags: @tags)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag = extract_tag(@book.body)
    if @book.save
      save_tag(tag,@book)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    delete_records_related_to_tag(params[:id])
    if @book.update(book_params)
      tag = extract_tag(@book.body)
      save_tag(tag,@book)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    delete_records_related_to_tag(params[:id])
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
