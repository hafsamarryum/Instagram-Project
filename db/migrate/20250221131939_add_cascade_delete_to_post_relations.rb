class AddCascadeDeleteToPostRelations < ActiveRecord::Migration[8.0]
  def change
     # Remove existing foreign keys
     remove_foreign_key :likes, :posts
     remove_foreign_key :comments, :posts
     remove_foreign_key :bookmarks, :posts
 
     # Add foreign keys with ON DELETE CASCADE
     add_foreign_key :likes, :posts, on_delete: :cascade
     add_foreign_key :comments, :posts, on_delete: :cascade
     add_foreign_key :bookmarks, :posts, on_delete: :cascade
  end
end
