class Job < ActiveRecord::Base
  validates :started_on, presence: true

  scope :active_in, Proc.new { |begin_date, end_date|
    end_date ||= begin_date
    where('started_on <= ?', begin_date).where('ended_on >= ?', end_date)
  }

  scope :ended_in, Proc.new { |begin_date, end_date|
    end_date ||= begin_date
    where('ended_on >= ?', begin_date).where('ended_on <= ?', end_date)
  }

  def self.active_count(begin_date, end_date = nil)
    active_in(begin_date, end_date).count
  end

  def self.ended_count(begin_date, end_date)
    active_in(begin_date).ended_in(begin_date, end_date).count
  end
end
