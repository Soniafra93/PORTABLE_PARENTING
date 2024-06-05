class Rental < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w[pending accepted declined] }
end
