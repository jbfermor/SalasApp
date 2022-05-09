class User < ApplicationRecord

  #Friendly_id
  extend FriendlyId
  friendly_id :name, use: :slugged


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  belongs_to :role

  belongs_to :super, class_name: "User", optional: true
  has_many :subordinates, class_name: "User", foreign_key: "super_id", dependent: :delete_all

  has_many :rooms, dependent: :delete_all
  has_many :teches, dependent: :delete_all
  has_many :reservations, dependent: :delete_all

  validates :name, presence: true
  validates :pc, length: {is: 5,
    message: "El Código Postal debe tener 5 caracteres"}, allow_blank: true
  validates :pc, format: { without: /\D/,
    message: "Sólo permite números" }, allow_blank: true
  validates :email2, format: { with: /\A[\w.+-]+@\w+\.\w+\z/,
    message: "El formato del mail alternativo no es correcto" }, allow_blank: true


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
