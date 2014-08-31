require 'spec_helper'

describe JobRates do
  before do
    Job.delete_all
    Job.create(started_on: '2014-01-01', ended_on: '2014-02-01')
    Job.create(started_on: '2014-01-01', ended_on: '2014-02-10')
    Job.create(started_on: '2014-01-01', ended_on: '2014-02-17')
    Job.create(started_on: '2014-02-02', ended_on: '2014-02-03')
    Job.create(started_on: '2014-02-02', ended_on: '2014-03-10')
  end
  let(:date) { '2014-02-16' }
  let(:churn_rate) { subject.churn_rate(date) } 
  let(:retention_rate) { subject.retention_rate(date) } 

  describe '#churn_rate' do
    it { expect(churn_rate).to eq((2.0 / 3 * 100).round(2)) }
  end

  describe '#retention_rate' do
    it { expect(retention_rate).to eq((1.0 / 3 * 100).round(2)) }
  end

  describe 'rates correlation' do
    it { expect(retention_rate).to eq(100 - churn_rate) }
  end
end