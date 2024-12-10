class Author < ApplicationRecord
    has_many :quotes, dependent: :destroy
    validates :fname, presence: true #Author must have first name
end
