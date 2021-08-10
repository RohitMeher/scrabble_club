class Match < ApplicationRecord
  has_many :participants
  has_many :members, through: :participants

  validates :start_date, :venue, presence: :true
end