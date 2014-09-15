class User < ActiveRecord::Base
  has_many :attendances
  has_many :events, through: :attendances

  def self.with_stats
    joins('LEFT JOIN attendances AS a ON a.user_id = users.id')
    .select("
      users.*,
      sum(case when a.status  = 'attended' then 1 else 0 end) as attended,
      sum(case when a.status  = 'noshow' then 1 else 0 end) as no_shows")
    .group('users.id')
  end
end
