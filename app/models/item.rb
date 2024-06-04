class Item < ApplicationRecord
  belongs_to :user
  has_many :rentals
  has_many :reviews
  has_many_attached :photos
  # has_one :address
  geocoded_by :address

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :photos, presence: true
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [:name, :description],
    using: {
      tsearch: { prefix: true }
    }
end
