require 'spec_helper'

describe JobRates do
  before { Job.delete_all }

  describe '#churn_rate' do
    before { allow(Job).to receive(:ended_count).and_return(1) }
    before { allow(Job).to receive(:average_count).and_return(3.5) }
    subject { described_class.new.churn_rate('2014-02-16') } 

    it { is_expected.to eq(1 / 3.5 * 100) }
  end

  describe '#retention_rate' do
    before { allow(Job).to receive(:active_count).and_return(8, 5) }
    subject { described_class.new.retention_rate('2014-02-16') }

    it { is_expected.to eq(5.0 / 8 * 100) }
  end
end