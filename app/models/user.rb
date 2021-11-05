class User < ApplicationRecord
    has_secure_password

    has_many :create_user_post, class_name: "Post", foreign_key: :create_user_id
    has_many :updated_user_post, class_name: "Post", foreign_key: :updated_user_id
end
