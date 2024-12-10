class Quote < ApplicationRecord
  belongs_to :author
  belongs_to :user
  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories
  accepts_nested_attributes_for :quote_categories, reject_if: :all_blank, allow_destroy: true #Handle nested attributes
  validates :text, presence: true #Text can't be blank
  validates :author_id, presence: true #Author can't be blank
  validates :quote_categories, presence: true #Quote Categories can't be blank
  validates :text, uniqueness: {scope: :author_id, message: 'Quote text has already exist'} #Quote text must be unique
end
