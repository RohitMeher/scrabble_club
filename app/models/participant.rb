class Participant < ApplicationRecord
  belongs_to :match
  belongs_to :member

  validates :score, presence: true

  module Status
    WIN  = 1
    LOSE = -1
    DRAW = 0
  end
end