class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :foods
  has_many :recipes, foreign_key: 'user_id', dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
