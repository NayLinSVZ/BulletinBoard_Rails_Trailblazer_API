class AddForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :posts, :users, column: :create_user_id
  end
end
