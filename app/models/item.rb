class Item < ApplicationRecord
  belongs_to :user
  has_many :rentals, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  geocoded_by :address

  validates :name, :description, :price, :photos, presence: true
  validates :price, numericality: { greater_than: 0 }
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [:name, :description],
    using: { tsearch: { prefix: true } }

    scope :available_for_rent, -> { where.not(id: Rental.pluck(:item_id)) }
end
