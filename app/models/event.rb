class Event < ApplicationRecord
  before_save { self.date = Time.now unless date.present? }

  belongs_to :creator, class_name: 'User'

  has_many :invitations, foreign_key: :attended_event_id
  has_many :attendees, through: :invitations
end
