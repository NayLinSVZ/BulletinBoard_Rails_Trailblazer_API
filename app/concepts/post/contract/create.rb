require "reform/form/validation/unique_validator"
module Post::Contract
  class Create < Reform::Form

    property :title
    property :description
    property :status
    property :create_user_id
    property :updated_user_id
    property :deleted_user_id
    property :deleted_at
    property :created_at
    property :updated_at

    validates :title, presence: true, unique: true
    validates :description, 
              :status,
              :create_user_id,
              :updated_user_id, presence: true
  end
end