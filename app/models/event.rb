class Event < ApplicationRecord
  validates :date, presence: true

  belongs_to :creator, class_name: 'User'

  has_many :invitations, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :invitations

  scope :past, -> { where("date < ?", Time.current) }
  scope :future, -> { where("date > ?", Time.current) }
  # default_scope -> { joins(:invitations) }
end
