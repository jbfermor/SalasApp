class Room < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :user
  has_many :reservations

  validates :name, presence: true

  def user_nil?
    if self.user_id.nil?
      self.user = current_user
    end
  end

end
