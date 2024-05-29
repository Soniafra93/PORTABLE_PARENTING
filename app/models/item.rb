class Item < ApplicationRecord
  belongs_to :user
  has_many :rentals
  has_many :reviews

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
