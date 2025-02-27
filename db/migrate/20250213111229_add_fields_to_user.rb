class AddFieldsToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :website, :string
    add_column :users, :bio, :text
  end
end
