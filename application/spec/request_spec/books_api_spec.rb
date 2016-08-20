require 'spec_helper'
require_relative '../../app/controllers/books_api'

RSpec.describe BooksApi do

  def app
    BooksApi
  end

  def json_body
    JSON.parse(response.body)
  end

  it 'returns Hello World with json format' do
    get '/'
    expect(response.content_type).to eq("application/json")
    expect(response.body).to eq('Hello World!'.to_json)
    expect(response.status).to eq 200
  end

  it "GET /books returns a list if all books" do
    book = create(:book)

    get "/books"

    expect(json_body.count).to eq(1)

    book_json = json_body[0]
    expect(book_json).to eq({
      "id" => book.id,
      "description" => book.description,
      "title" => book.title,
      "url" => book.url,
    })
    expect(response.status).to eq 200
  end

  it "GET /books/1 returns a book" do
    book = create(:book)

    get "/books/1"

    expect(json_body).to eq({
      "id" => book.id,
      "description" => book.description,
      "title" => book.title,
      "url" => book.url,
    })
    expect(response.status).to eq 200
  end

  it "POST /books create a new book" do
    expect(Book.count).to eq 0
    book_params = attributes_for(:book)
    post "/books", book: book_params

    expect(response.status).to eq 201
    expect(Book.last.title).to eq book_params[:title]
  end

  context "when there are invalid attributes" do
    it "returns a 422, with errors" do
      book_params = attributes_for(:book, :invalid)

      post "/books", book: book_params

      expect(response.status).to eq 422
      expect(json_body).not_to be_empty
    end
  end

  it "PUT /books/1 update the book title" do
    book = create(:book)

    put '/books/1', book: { title: "Testing in Sinatra"}

    expect(response.status).to eq 200
    expect(Book.last.title).to eq "Testing in Sinatra"
  end

  it "DELETE /books/1" do
    book = create(:book)
    expect(Book.count).to eq 1

    delete '/books/1'

    expect(response.status).to eq 204
    expect(Book.count).to eq 0
  end
end
