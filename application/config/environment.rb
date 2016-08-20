require 'bundler'
Bundler.require
require './config/db_config'

environment = ENV.fetch('RACK_ENV')
config = DBConfig.new(environment).options
ActiveRecord::Base.establish_connection(config)

require './app/models/book'
