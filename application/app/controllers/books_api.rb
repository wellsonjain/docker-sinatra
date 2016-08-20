require './app/models/book'

class BooksApi < Sinatra::Base
  get '/' do
    json 'Hello World!'
  end

  get '/books' do
    json Book.all
  end

  get '/books/:id' do
    book = Book.find(params[:id])

    if book
      book.to_json
    else
      status 404
      book.errors.to_json
    end
  end

  post '/books' do
    book = Book.new(params[:book])

    if book.save
      status 201
    else
      status 422
      book.errors.to_json
    end
  end

  put '/books/:id' do
    book = Book.find(params[:id])

    book.update(params[:book])
    if book.save
      status 200
    else
      status 422
      book.errors.to_json
    end
  end

  delete '/books/:id' do
    book = Book.find(params[:id])
    if book.destroy
      status 204
    else
      status 422
      book.errors.to_json
    end
  end
end
