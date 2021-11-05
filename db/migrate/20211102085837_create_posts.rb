class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string "title"
      t.text "description", size: :long
      t.integer "status", limit: 1
      t.bigint "create_user_id"
      t.bigint "updated_user_id" 
      t.integer "deleted_user_id"
      t.datetime "deleted_at", precision: 6

      t.timestamps
    end
  end
end

