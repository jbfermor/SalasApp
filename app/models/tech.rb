class Tech < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :user
  has_many :reservations

  validates :name, presence: true
end
