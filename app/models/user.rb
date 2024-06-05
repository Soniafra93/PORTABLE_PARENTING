class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    has_many :items, dependent: :destroy
    has_many :rentals, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_one_attached :photo

    def owner_of?(item)
      item.user_id == id
    end
end
