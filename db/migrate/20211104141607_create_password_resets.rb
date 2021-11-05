class CreatePasswordResets < ActiveRecord::Migration[6.1]
  def change
    create_table :password_resets do |t|
      t.string :email, varchar: 255
      t.text :token, size: :long
      
      t.timestamps
    end
  end
end
