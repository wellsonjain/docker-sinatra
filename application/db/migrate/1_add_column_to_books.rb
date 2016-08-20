class AddColumnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :title, :string
    add_column :books, :url, :string
  end
end
