class Post < ApplicationRecord
  belongs_to :create_user, class_name: 'User' 
  belongs_to :updated_user, class_name: 'User'

  validates :title, uniqueness: true
end
