require 'date'

def get_date
  [rand(5).months.ago, rand(5).months.from_now].sample
end

20.times { User.create(name: Faker::Name.name) }

12.times do
  user = User.find(rand(1...21))

  event_desc = Faker::Lorem.sentence
  event_address = Faker::Address.full_address
  event_date = Faker::Time.between(from: DateTime.now - rand(100), to: DateTime.now + rand(100), format: :long)
  event = user.events.create(description: event_desc, date: event_date, location: event_address)

  attendees = User.offset(rand(14)).first(rand(12))
  attendees.each do |attendee|
    attendee.attended_events << event
  end
end
