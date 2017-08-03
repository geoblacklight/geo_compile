require "spec_helper"

RSpec.describe GeoCompile do
  describe '#translate' do
    subject { described_class }
    it 'has a translate method' do
      expect { subject.translate('metadata', :GBL2_0, :SOLR2_0) }.not_to raise_error
    end
  end

  describe '#validate' do
    subject { described_class }
    it 'has a validate method' do
      expect(subject.validate('metadata', :fgdc))
    end
  end  
end
