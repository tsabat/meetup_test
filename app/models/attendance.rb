class Attendance < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  def self.full_event
    joins('LEFT JOIN events AS e ON e.id = attendances.event_id')
    .select("
      attendances.*, e.name, e.scheduled
    ")
  end
end
