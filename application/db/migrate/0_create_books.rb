class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :description
    end
  end
end
