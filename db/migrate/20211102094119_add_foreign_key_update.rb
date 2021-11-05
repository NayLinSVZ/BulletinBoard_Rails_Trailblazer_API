class AddForeignKeyUpdate < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :posts, :users, column: :updated_user_id
  end
end
