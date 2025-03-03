class AddArchivedToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :archived, :boolean, default: false
  end
end
