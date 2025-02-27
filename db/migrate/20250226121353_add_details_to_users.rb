class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
    add_column :users, :location, :string
  end
end
