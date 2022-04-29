class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :room
  belongs_to :tech

  validates :title, presence: true
  validates :start_time, comparison: { greater_than: Time.now }
  validates :end_time, comparison: { greater_than: :start_time }

end
