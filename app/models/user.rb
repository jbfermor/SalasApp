class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role
  belongs_to :super, class_name: "User", optional: true

  has_many :subordinates, class_name: "User", foreign_key: "super_id"

  def admin?
    role.id == 1
  end

  def super?
    role.id == 2
  end

  def user?
    role.id == 3
  end
  
end
