require 'spec_helper'

describe Job do
  before { Job.delete_all }

  subject { described_class.create(developer: 'John Doe', started_on: started_on) }
  let(:started_on) { Date.today }

  it { should be_valid }
  it { expect(subject.developer).to eq 'John Doe' }

  context "start date is not set" do
    let(:started_on) { nil }
    it { should_not be_valid }
  end

  describe '#active_count' do
    before do
      Job.create(started_on: '2014-01-01', ended_on: '2014-02-01')
      Job.create(started_on: '2014-01-01', ended_on: '2014-02-17')
      Job.create(started_on: '2014-02-02', ended_on: '2014-02-03')
      Job.create(started_on: '2014-02-02', ended_on: '2014-03-10')
    end
    subject { described_class.active_count('2014-02-01', '2014-02-15') }

    it 'returns count of jobs active during the period' do
      is_expected.to eq 1
    end
  end

  describe '#ended_count' do
    before do
      Job.create(started_on: '2014-01-01', ended_on: '2014-01-01')
      Job.create(started_on: '2014-01-01', ended_on: '2014-02-01')
      Job.create(started_on: '2014-01-01', ended_on: '2014-03-01')
      Job.create(started_on: '2014-02-02', ended_on: '2014-02-10')
    end
    subject { described_class.ended_count('2014-02-01', '2014-02-15') }

    it 'returns count of jobs resigned during the period' do
      is_expected.to eq 1
    end
  end
end
