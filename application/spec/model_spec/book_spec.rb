require 'spec_helper'
require_relative '../../app/models/book'

RSpec.describe Book, type: :model  do
  it { should validate_presence_of(:title) }
end
