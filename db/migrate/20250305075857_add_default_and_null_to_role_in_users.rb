class AddDefaultAndNullToRoleInUsers < ActiveRecord::Migration[8.0]
  def up
    change_column_default :users, :role, 0
    change_column_null :users, :role, false
  end

  def down
    # Revert the default value and null constraint to their previous state
    change_column_default :users, :role, from: 0, to: nil  # or whatever the previous default was
    change_column_null :users, :role, true  # allow null values again
  end
end
