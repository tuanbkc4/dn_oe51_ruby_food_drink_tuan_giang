class RenameColumnInUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :userName, :user_name
    rename_column :users, :fullName, :full_name
  end
end
