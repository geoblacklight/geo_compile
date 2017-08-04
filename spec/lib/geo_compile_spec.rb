require "spec_helper"

RSpec.describe GeoCompile do
  describe '#translate' do
    it 'has a translate method' do
      expect { described_class.translate('metadata', :GBL2_0, :SOLR2_0) }.not_to raise_error
    end
  end

  describe '#validate' do
    let(:metadata) { fixture('docs/full_geoblacklight.json') }
    it 'has a validate method that returns an instance of a validator' do
      expect(described_class.validate(metadata, :GBL1_0)).to be_a GeoCompile::Validator
    end
  end
end
