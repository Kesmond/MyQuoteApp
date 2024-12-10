class User < ApplicationRecord
    has_secure_password
    has_many :quotes, dependent: :destroy
    validates :fname, presence: true #User must have its first name
    validates :lname, presence: true #User must have its last name
    validates :email, presence: true, uniqueness: true #User must have an email and has to be unqiue among other users
end
