class User < ApplicationRecord
  before_save { name.capitalize! }
  
  validates :name, presence: true, length: {within: 3..50}
  validates_uniqueness_of :name

  has_many :events, foreign_key: :creator_id, dependent: :destroy

  has_many :invitations, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :invitations

  scope :other_users, ->(user) { where.not('id = ?', user.id) }

  def upcoming_events
    self.events.where("date > ?", Time.current)
  end

  def previous_events
    self.events.where("date < ?", Time.current)
  end

  def upcoming_invitations
    self.attended_events.where("date > ?", Time.current)
  end

  def previous_invitations
    self.attended_events.where("date < ?", Time.current)
  end
end
