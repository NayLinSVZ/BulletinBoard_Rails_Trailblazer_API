class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, varchar: 255
      t.string :email, varchar: 255
      t.string :password_digest
      t.string :profile , varchar: 255
      t.integer :role ,:limit=>1
      t.string :phone, varchar: 20
      t.string :address, varchar: 255
      t.date :dob
      t.integer :create_user_id
      t.integer :updated_user_id
      t.integer :deleted_user_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
