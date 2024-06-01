class Item < ApplicationRecord
  belongs_to :user
  has_many :rentals
  has_many :reviews
  has_many_attached :photos

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :photos, presence: true
end
