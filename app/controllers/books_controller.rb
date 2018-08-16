class BooksController < ApplicationController

    def index
      @books = Book.all
    end

    def new
        @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to root_path
      else
        render 'new'
      end
    end

    def edit
    end

    private
    def book_params
      params.require(:book).permit(:title, :description, :author)
    end
end
