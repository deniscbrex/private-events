class User < ApplicationRecord
  before_save { name.capitalize! }

  has_many :events, foreign_key: :creator_id, dependent: :destroy

  has_many :invitations, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :invitations

  scope :other_users, ->(user) { where.not('id = ?', user.id) }

  def upcoming_events
    self.attended_events.where("date > ?", Time.current)
  end

  def previous_events
    self.attended_events.where("date < ?", Time.current)
  end
end
