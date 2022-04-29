class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :room
  belongs_to :tech

  validates :title, presence: true
  validates :start_time, comparison: { greater_than: :end_time }

end
