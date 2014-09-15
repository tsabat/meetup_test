namespace :meetup do
  desc 'Meetup Rake task'

  desc 'Import Users'
  task :import_users => :environment do
    meetup_api = MeetupApi.new
    users      = meetup_api.members(group_id: 376808)

    users['results'].each do |muser|
      User.create_with(name: muser['name']).find_or_create_by(meetup_id: muser['id'])
      print '.'
    end
  end


  desc 'Import Events'
  task :import_events => :environment do
    meetup_api = MeetupApi.new
    events     = meetup_api.events(group_id: 376808)

    events['results'].each do |mevent|
      time = Time.at(mevent['time']/1000)

      Event.create_with(name: mevent['name'],scheduled: time).find_or_create_by(meetup_id: mevent['id'])
      print '.'
    end
  end

  desc 'Import Attendance'
  task :import_attendance => :environment do
    meetup_api = MeetupApi.new

    events = Event.all.find_each do |event|
      attendances = meetup_api.attendance(urlname: 'momsmeetupofco', event_id: event.meetup_id)

      puts attendances

      if attendances.is_a?(Hash) && attendances.key?('errors')
        print 'F'
      else
         attendances.each do |attendance|
            Attendance.find_or_create_by(event_id: event.id) do |a|
             user        = User.find_by(meetup_id: attendance['member']['id'].to_i)
             a.status    = attendance['status']
             a.rsvp      = attendance['rsvp']['response']
             a.user      = user
             a.scheduled = event.scheduled
             a.event     = event
           end
           print '.'
         end
      end
    end
  end
end
