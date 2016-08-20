$:.unshift File.expand_path("./../app", __FILE__)
require 'bundler'
Bundler.require
require './app/controllers/books_api'

run BooksApi
