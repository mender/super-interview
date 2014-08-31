class JobRates
  def churn_rate(date)
    begin_date, end_date = period(date)

    was   = Job.active_count(begin_date)
    ended = Job.ended_count(begin_date, end_date)
    (ended.to_f / was * 100).round(2)
  end

  def retention_rate(date)
    begin_date, end_date = period(date)

    was   = Job.active_count(begin_date)
    still = Job.active_count(begin_date, end_date)
    (still.to_f / was * 100).round(2)
  end

  private

  def period(date)
    date = Date.parse(date)
    begining = date.beginning_of_month
    ending = date
    [begining, ending]
  end
end