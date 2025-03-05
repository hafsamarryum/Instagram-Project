class AddStatusToUsers < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :status, :boolean, default: true
  end

  def down
    remove_column :users, :status
  end
end
