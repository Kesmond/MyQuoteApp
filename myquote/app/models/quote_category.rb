class QuoteCategory < ApplicationRecord
  belongs_to :quote
  belongs_to :category
  validates :category_id, presence: true #Quote must have a category
  validates_uniqueness_of :category_id, scope: :quote_id #A quote can't have the same category twice
end
