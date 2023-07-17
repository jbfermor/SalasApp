class Reservation < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  belongs_to :room
  belongs_to :tech

  validates :title, presence: true
  validates :start_time, comparison: { greater_than: Time.now }
  validates :end_time, comparison: { greater_than: :start_time }

  scope :super_reservation, -> { where(day: @start_date, user_id: current_user).order(:start_time) }

end
