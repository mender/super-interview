class JobRates
  def churn_rate(date)
    begin_date, end_date = period(date)

    resigned = Job.ended_count(begin_date, end_date)
    average  = Job.average_count(begin_date, end_date)
    (resigned / average) * 100
  end

  def retention_rate(date)
    begin_date, end_date = period(date)

    was   = Job.active_count(begin_date)
    still = Job.active_count(begin_date, end_date)
    (still.to_f / was) * 100
  end

  private

  def period(date)
    date = Date.parse(date)
    begining = date.beginning_of_month
    ending = date
    [begining, ending]
  end
end