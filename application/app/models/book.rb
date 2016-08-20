require 'active_record'
require_relative '../../config/environment'

class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true
end
