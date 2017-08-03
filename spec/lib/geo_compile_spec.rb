require "spec_helper"

RSpec.describe GeoCompile do
  describe '#translate' do
    it 'has a translate method' do
      expect { described_class.translate('metadata', :GBL2_0, :SOLR2_0) }.not_to raise_error
    end
  end

  describe '#validate' do
    it 'has a validate method' do
      expect(described_class.validate('metadata', :fgdc))
    end
  end
end
