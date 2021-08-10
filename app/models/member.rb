class Member < ActiveRecord::Base
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  has_many :participants
  has_many :matches, through: :participants

  validates :user_name, uniqueness: true
  validates :first_name, :user_name, presence: true

  before_create :add_join_date

  scope :with_contact_number, -> (l) { joins(:addresses).select("members.*, addresses.phone_number").order('members.created_at desc').limit(l)}

  def add_join_date
    self.join_date = Date.current
  end

  def score_statistics
    @score_statistics ||= participants.select("AVG(score) as avg_score, MAX(score) as max_score").first
  end

  def average_score    
    score_statistics.blank? ? nil : score_statistics.avg_score
  end

  def maximum_score    
    score_statistics.blank? ? nil : score_statistics.max_score
  end

  def loses
    participants.where(:status => Participant::Status::LOSE).count
  end

  def draws
    participants.where(:status => Participant::Status::DRAW).count
  end

  def max_score_match
    return unless maximum_score
    match_id = participants.find_by(score: maximum_score).match_id
    matches.find(match_id)
  end

  def max_match_opponent
    max_score_match.members.where.not(id: id).first if max_score_match
  end

  def self.top_members(limit= 10)
    @top_members ||= joins(:participants, :addresses).select("members.*, AVG(score) as avg_score, addresses.phone_number").group("members.id").where("members.matches_played >= ?", leader_board_member_matches).order('avg_score desc').limit(limit)
  end

  def self.leader_board_member_matches
    10    
  end

end