require "spec_helper"

RSpec.describe GeoCompile::FormatTranslators::GBL1_0_to_GBL2_0 do
  let(:metadata) { fixture('docs/full_geoblacklight.json') }

  describe '#translate' do
    context 'with a geoblacklight 1.0 document' do
      it 'returns a valid geoblacklight 2.0 document' do
        doc = described_class.new.translate(metadata)
        expect(GeoCompile.validate(doc, :GBL2_0).valid?).to be true
      end
    end
  end
end
