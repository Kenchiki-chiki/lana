class Channel < ApplicationRecord
  has_many :participations
  has_many :users, through: :participations
  has_many :messages

  validates :name, presence: true, uniqueness: true
end
