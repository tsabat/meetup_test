class MeetupApi
  include HTTParty
  base_uri 'http://api.meetup.com/'
  API_KEY = #API KEY

  attr_accessor :options

  def initialize
    @options = { query: {key: API_KEY} }
  end

  def events(group_id:, status: 'past', desc: true, time: '1316121739488,1410816101633')
    @options[:query].merge!(group_id: group_id, status: status, time: time, desc: desc)

    self.class.get("/2/events", @options)
  end

  def members(group_id:)
    @options[:query].merge!(group_id: group_id)
    self.class.get("/2/members", @options)
  end

  def attendance(urlname:, event_id:)
    self.class.get("/#{urlname}/events/#{event_id}/attendance", @options)
  end
end

