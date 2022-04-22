class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :tech
end
